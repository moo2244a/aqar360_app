import 'package:flutter/material.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';
import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/company_layout/presentation/widgets/rfq_chat_widget.dart';

class UserRfqDetailsScreen extends StatefulWidget {
  final RfqModel rfq;

  const UserRfqDetailsScreen({super.key, required this.rfq});

  @override
  State<UserRfqDetailsScreen> createState() => _UserRfqDetailsScreenState();
}

class _UserRfqDetailsScreenState extends State<UserRfqDetailsScreen> {
  late RfqModel _rfq;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _rfq = widget.rfq;
  }

  Future<void> _respondToQuote(bool accepted) async {
    setState(() => _isLoading = true);
    try {
      await FirebaseHelper.respondToRfqQuote(
        rfqId: _rfq.id,
        accepted: accepted,
        companyId: _rfq.companyId,
        projectTitle: _rfq.projectTitle,
      );
      setState(() {
        _rfq.status = accepted ? rfqUserApproved : rfqUserRejected;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              accepted ? 'تم قبول عرض السعر بنجاح!' : 'تم رفض عرض السعر.',
            ),
            backgroundColor: accepted ? Colors.green : Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $e'), backgroundColor: Colors.red),
        );
      }
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
            'تفاصيل ومحادثة الطلب',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoCard(),
                const SizedBox(height: 12),
                _buildQuoteSection(),
                const SizedBox(height: 12),
                const Divider(thickness: 1.5),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      'المحادثة والتفاوض',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 450, child: RfqChatWidget(rfqId: _rfq.id)),
                const SizedBox(height: 16),
              ],
            ),
          ),
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
              'إلى شركة: ${_rfq.companyName}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF1B4332),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _rfq.projectTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
            const Divider(height: 20),
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
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteSection() {
    if (_rfq.status == rfqQuoted && _rfq.quotedPrice != null) {
      return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.blue.shade200, width: 1.5),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.price_check, color: Colors.blue, size: 22),
                  const SizedBox(width: 8),
                  const Text(
                    'عرض السعر من الشركة',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 20,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_rfq.quotedPrice!.toStringAsFixed(0)} ج.م',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (_rfq.companyNote != null && _rfq.companyNote!.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  'ملاحظة الشركة: ${_rfq.companyNote}',
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
              const SizedBox(height: 16),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _respondToQuote(true),
                        icon: const Icon(Icons.check_circle_outline, size: 18),
                        label: const Text(
                          'قبول العرض',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _respondToQuote(false),
                        icon: const Icon(Icons.cancel_outlined, size: 18),
                        label: const Text(
                          'رفض العرض',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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

    if (_rfq.status == rfqUserApproved) {
      return _buildBanner(
        '✅ وافقت على عرض السعر بـ ${_rfq.quotedPrice?.toStringAsFixed(0)} ج.م. تواصل مع الشركة لإتمام الخدمة.',
        Colors.green,
      );
    }
    if (_rfq.status == rfqUserRejected) {
      return _buildBanner(
        'رفضت عرض السعر. يمكنك التحدث مع الشركة في المحادثة للتفاوض.',
        Colors.orange,
      );
    }
    if (_rfq.status == rfqPending) {
      return _buildBanner(
        '⏳ في انتظار رد الشركة وإرسال عرض السعر...',
        Colors.orange,
      );
    }
    if (_rfq.status == rfqRejected) {
      return _buildBanner('❌ تم رفض طلبك من قِبَل الشركة.', Colors.red);
    }
    return const SizedBox.shrink();
  }

  Widget _buildBanner(String msg, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Text(
        msg,
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
        return 'عرض سعر جديد!';
      case rfqUserApproved:
        return 'تم القبول';
      case rfqUserRejected:
        return 'رفضت العرض';
      case rfqRejected:
        return 'مرفوض';
      case rfqCompleted:
        return 'مكتمل';
      default:
        return status;
    }
  }
}
