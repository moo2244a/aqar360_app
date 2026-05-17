import 'package:flutter/material.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';
import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/company_layout/presentation/widgets/rfq_chat_widget.dart';

class CompanyRfqDetailsScreen extends StatefulWidget {
  final RfqModel rfq;
  final VoidCallback onStatusChanged;

  const CompanyRfqDetailsScreen({
    super.key,
    required this.rfq,
    required this.onStatusChanged,
  });

  @override
  State<CompanyRfqDetailsScreen> createState() =>
      _CompanyRfqDetailsScreenState();
}

class _CompanyRfqDetailsScreenState extends State<CompanyRfqDetailsScreen> {
  late RfqModel _rfq;
  final _priceController = TextEditingController();
  final _noteController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _rfq = widget.rfq;
    if (_rfq.quotedPrice != null) {
      _priceController.text = _rfq.quotedPrice!.toStringAsFixed(0);
    }
    if (_rfq.companyNote != null) {
      _noteController.text = _rfq.companyNote!;
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _sendQuote() async {
    final priceText = _priceController.text.trim();
    if (priceText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('يرجى إدخال السعر المقترح')));
      return;
    }
    final price = double.tryParse(priceText);
    if (price == null || price <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('يرجى إدخال سعر صحيح')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseHelper.updateRfqWithQuote(
        rfqId: _rfq.id,
        quotedPrice: price,
        companyNote: _noteController.text.trim(),
        userId: _rfq.userId!,
        projectTitle: _rfq.projectTitle,
      );
      setState(() {
        _rfq.status = rfqQuoted;
        _rfq.quotedPrice = price;
        _rfq.companyNote = _noteController.text.trim();
      });
      widget.onStatusChanged();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال عرض السعر بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _rejectRfq() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseHelper.updateRfqStatus(_rfq.id, rfqRejected);
      setState(() => _rfq.status = rfqRejected);
      widget.onStatusChanged();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9F7),
        appBar: AppBar(
          title: const Text(
            'تفاصيل الطلب',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(),
                  const SizedBox(height: 12),
                  _buildActionSection(),
                ],
              ),
            ),
            const Divider(thickness: 1.5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'المحادثة والتفاوض',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            Expanded(child: RfqChatWidget(rfqId: _rfq.id)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _rfq.projectTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF1B4332),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _rfq.details,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const Divider(height: 24),
            Row(
              children: [
                const Text(
                  'الحالة: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(_rfq.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _statusText(_rfq.status),
                    style: TextStyle(
                      color: _statusColor(_rfq.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // Show quoted price if already sent
            if (_rfq.quotedPrice != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.price_check, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      'عرض السعر المرسل: ${_rfq.quotedPrice!.toStringAsFixed(0)} ج.م',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionSection() {
    // If already quoted or user responded, show readonly
    if (_rfq.status == rfqUserApproved) {
      return _buildStatusBanner(
        '✅ وافق العميل على عرض السعر! يمكنك الآن البدء في التنفيذ.',
        Colors.green,
      );
    }
    if (_rfq.status == rfqUserRejected) {
      return _buildStatusBanner(
        '❌ رفض العميل عرض السعر. يمكنك إرسال عرض جديد.',
        Colors.red,
      );
    }
    if (_rfq.status == rfqRejected) {
      return _buildStatusBanner('تم رفض هذا الطلب.', Colors.red);
    }
    if (_rfq.status == rfqCompleted) {
      return _buildStatusBanner('✅ تم إنهاء هذا الطلب بنجاح.', Colors.green);
    }

    // Show quote form for pending/user_rejected
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'إرسال عرض السعر',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'السعر المقترح (ج.م)',
                prefixIcon: const Icon(Icons.attach_money),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _noteController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'ملاحظة للعميل (اختياري)',
                prefixIcon: const Icon(Icons.note_outlined),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _sendQuote,
                    icon: const Icon(Icons.send, size: 18),
                    label: _isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'إرسال عرض السعر',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B4332),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isLoading ? null : _rejectRfq,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'رفض الطلب',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner(String message, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case rfqUserApproved:
        return Colors.green;
      case rfqQuoted:
        return Colors.blue;
      case rfqRejected:
      case rfqUserRejected:
        return Colors.red;
      case rfqCompleted:
        return Colors.teal;
      default:
        return Colors.orange;
    }
  }

  String _statusText(String status) {
    switch (status) {
      case rfqPending:
        return 'قيد الانتظار';
      case rfqQuoted:
        return 'تم إرسال العرض';
      case rfqUserApproved:
        return 'قبل العميل';
      case rfqUserRejected:
        return 'رفض العميل';
      case rfqRejected:
        return 'مرفوض';
      case rfqCompleted:
        return 'مكتمل';
      default:
        return status;
    }
  }
}
