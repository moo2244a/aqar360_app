import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aqar360/app/core/constants/property_status.dart';
import 'package:aqar360/app/core/models/property_offer_model.dart';
import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/user_layout/presentation/screens/property_deal_chat_screen.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';

class PropertyNegotiationScreen extends StatefulWidget {
  final PropertyOfferModel offer;
  final PropertyDetails? property;

  const PropertyNegotiationScreen({
    super.key,
    required this.offer,
    this.property,
  });

  @override
  State<PropertyNegotiationScreen> createState() =>
      _PropertyNegotiationScreenState();
}

class _PropertyNegotiationScreenState extends State<PropertyNegotiationScreen> {
  late PropertyOfferModel _offer;
  final _counterCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  bool _loading = false;
  late final String _uid;
  late final bool _isOwner;

  @override
  void initState() {
    super.initState();
    _offer = widget.offer;
    _uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    _isOwner = _uid == _offer.ownerId;
  }

  @override
  void dispose() {
    _counterCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  // ── OWNER: Accept offer ──
  Future<void> _accept() async {
    final agreedPrice = _offer.offeredPrice;
    // Show confirmation with the agreed price
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'تأكيد قبول العرض',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    const Text(
                      'سعر الاتفاق',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${agreedPrice.toStringAsFixed(0)} ج.م',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'هل توافق على ${_offer.isForSale ? "بيع" : "تأجير"} العقار بهذا السعر؟',
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('نعم، موافق'),
            ),
          ],
        ),
      ),
    );
    if (confirmed != true) return;
    setState(() => _loading = true);
    try {
      await FirebaseHelper.respondToPropertyOffer(
        offerId: _offer.id,
        accepted: true,
        buyerId: _offer.buyerId,
        buyerName: _offer.buyerName,
      );
      await FirebaseHelper.rejectOtherOffersForProperty(
        propertyId: _offer.propertyId,
        acceptedOfferId: _offer.id,
        isForSale: _offer.isForSale,
      );
      await FirebaseHelper.purchaseOrRentProperty(
        propertyId: _offer.propertyId,
        buyerId: _offer.buyerId,
        status: _offer.isForSale ? PropertyStatus.sold : PropertyStatus.rented,
        agreedPrice: agreedPrice,
      );
      await FirebaseHelper.initPropertyDeal(
        propertyId: _offer.propertyId,
        propertyTitle: _offer.propertyTitle,
        buyerId: _offer.buyerId,
        ownerId: _offer.ownerId,
        price: agreedPrice,
        isForSale: _offer.isForSale,
      );
      setState(() => _offer.status = offerAccepted);
      if (mounted)
        _snack('✅ تم قبول العرض بـ ${agreedPrice.toStringAsFixed(0)} ج.م');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ── OWNER: Reject ──
  Future<void> _reject() async {
    setState(() => _loading = true);
    try {
      await FirebaseHelper.respondToPropertyOffer(
        offerId: _offer.id,
        accepted: false,
        buyerId: _offer.buyerId,
        buyerName: _offer.buyerName,
        ownerNote: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
      );
      setState(() => _offer.status = offerRejected);
      if (mounted) _snack('تم رفض العرض.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ── OWNER: Counter offer ──
  Future<void> _counter() async {
    final price = double.tryParse(_counterCtrl.text.trim());
    if (price == null || price <= 0) {
      _snack('أدخل سعراً صحيحاً');
      return;
    }
    setState(() => _loading = true);
    try {
      await FirebaseHelper.respondToPropertyOffer(
        offerId: _offer.id,
        accepted: false,
        buyerId: _offer.buyerId,
        buyerName: _offer.buyerName,
        counterPrice: price,
        ownerNote: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
      );
      setState(() {
        _offer.status = offerCountered;
        _offer.counterPrice = price;
      });
      if (mounted) _snack('تم إرسال العرض المضاد.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ── BUYER: Accept counter ──
  Future<void> _acceptCounter() async {
    if (_offer.counterPrice == null) return;
    setState(() => _loading = true);
    try {
      await FirebaseHelper.respondToPropertyOffer(
        offerId: _offer.id,
        accepted: true,
        buyerId: _offer.buyerId,
        buyerName: _offer.buyerName,
      );
      await FirebaseHelper.rejectOtherOffersForProperty(
        propertyId: _offer.propertyId,
        acceptedOfferId: _offer.id,
        isForSale: _offer.isForSale,
      );
      await FirebaseHelper.purchaseOrRentProperty(
        propertyId: _offer.propertyId,
        buyerId: _offer.buyerId,
        status: _offer.isForSale ? PropertyStatus.sold : PropertyStatus.rented,
        agreedPrice: _offer.counterPrice!,
      );
      await FirebaseHelper.initPropertyDeal(
        propertyId: _offer.propertyId,
        propertyTitle: _offer.propertyTitle,
        buyerId: _offer.buyerId,
        ownerId: _offer.ownerId,
        price: _offer.counterPrice!,
        isForSale: _offer.isForSale,
      );
      setState(() => _offer.status = offerAccepted);
      if (mounted) {
        _snack('✅ قبلت العرض! تم فتح قناة التواصل.');
        if (widget.property != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => PropertyDealChatScreen(
                property: widget.property!,
                isBuyer: true,
              ),
            ),
          );
        }
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ── BUYER: New offer ──
  void _sendNewOffer() {
    _counterCtrl.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'أرسل عرضاً جديداً',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _counterCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'السعر المقترح (ج.م)',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final price = double.tryParse(_counterCtrl.text.trim());
                    if (price == null || price <= 0) return;
                    Navigator.pop(context);
                    setState(() => _loading = true);
                    try {
                      final newOffer = PropertyOfferModel(
                        id: '',
                        propertyId: _offer.propertyId,
                        propertyTitle: _offer.propertyTitle,
                        buyerId: _offer.buyerId,
                        buyerName: _offer.buyerName,
                        ownerId: _offer.ownerId,
                        offeredPrice: price,
                        isForSale: _offer.isForSale,
                        createdAt: DateTime.now(),
                      );
                      await FirebaseHelper.addPropertyOffer(newOffer);
                      if (mounted) _snack('تم إرسال عرضك الجديد!');
                    } finally {
                      if (mounted) setState(() => _loading = false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4332),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'إرسال',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _snack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9F7),
        appBar: AppBar(
          title: Text(
            _isOwner ? 'عرض سعر وصلك' : 'عرضي على العقار',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Property Info
              _infoCard(),
              const SizedBox(height: 16),
              // Offer Timeline
              _offerTimeline(),
              const SizedBox(height: 16),
              // Actions
              if (_loading)
                const Center(child: CircularProgressIndicator())
              else
                _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B4332).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.home, color: Color(0xFF1B4332)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _offer.propertyTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1B4332),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _isOwner
                            ? 'من: ${_offer.buyerName}'
                            : 'طلب ${_offer.isForSale ? "شراء" : "إيجار"}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusBadge(_offer.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _offerTimeline() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'مراحل التفاوض',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 16),
            // Step 1: Buyer offer
            _timelineStep(
              icon: Icons.person,
              color: Colors.blue,
              title: 'عرض ${_offer.buyerName}',
              value: '${_offer.offeredPrice.toStringAsFixed(0)} ج.م',
              isDone: true,
            ),
            // Step 2: Counter (if any)
            if (_offer.counterPrice != null)
              _timelineStep(
                icon: Icons.storefront,
                color: Colors.orange,
                title: 'عرض مضاد من صاحب العقار',
                value: '${_offer.counterPrice!.toStringAsFixed(0)} ج.م',
                note: _offer.ownerNote,
                isDone: true,
              ),
            // Step 3: Final
            if (_offer.status == offerAccepted)
              _timelineStep(
                icon: Icons.check_circle,
                color: Colors.green,
                title: 'تمت الصفقة',
                value:
                    '${(_offer.counterPrice ?? _offer.offeredPrice).toStringAsFixed(0)} ج.م',
                isDone: true,
              ),
            if (_offer.status == offerRejected)
              _timelineStep(
                icon: Icons.cancel,
                color: Colors.red,
                title: 'تم رفض العرض',
                value: _offer.ownerNote ?? '',
                isDone: true,
              ),
          ],
        ),
      ),
    );
  }

  Widget _timelineStep({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
    String? note,
    required bool isDone,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, color: color, size: 18),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (note != null && note.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    note,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    // Closed offers
    if (_offer.status == offerAccepted || _offer.status == offerRejected) {
      if (_offer.status == offerAccepted && widget.property != null) {
        return ElevatedButton.icon(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => PropertyDealChatScreen(
                property: widget.property!,
                isBuyer: !_isOwner,
              ),
            ),
          ),
          icon: const Icon(Icons.chat),
          label: const Text(
            'فتح قناة التواصل',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B4332),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        );
      }
      return _banner(
        _offer.status == offerAccepted
            ? '✅ تمت الصفقة بنجاح!'
            : '❌ تم رفض العرض.${_offer.ownerNote != null ? '\n${_offer.ownerNote}' : ''}',
        _offer.status == offerAccepted ? Colors.green : Colors.red,
      );
    }

    // OWNER actions
    if (_isOwner &&
        (_offer.status == offerPending || _offer.status == offerCountered)) {
      return Column(
        children: [
          // Accept button shows the offered price clearly
          ElevatedButton.icon(
            onPressed: _accept,
            icon: const Icon(Icons.check_circle_outline),
            label: Text(
              'قبول العرض بـ ${_offer.offeredPrice.toStringAsFixed(0)} ج.م ✅',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Counter offer section
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'أو أرسل عرضاً مضاداً',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _counterCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'السعر المضاد (ج.م)',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _noteCtrl,
                    decoration: InputDecoration(
                      labelText: 'ملاحظة (اختياري)',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _reject,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'رفض',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _counter,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'إرسال عرض مضاد',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    // BUYER: accept counter or send new offer
    if (!_isOwner) {
      return Column(
        children: [
          if (_offer.status == offerCountered &&
              _offer.counterPrice != null) ...[
            _banner(
              'صاحب العقار اقترح سعر ${_offer.counterPrice!.toStringAsFixed(0)} ج.م${_offer.ownerNote != null ? '\n${_offer.ownerNote}' : ''}',
              Colors.orange,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _acceptCounter,
              icon: const Icon(Icons.check_circle_outline),
              label: Text(
                'قبول العرض المضاد ${_offer.counterPrice!.toStringAsFixed(0)} ج.م',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          if (_offer.status == offerPending)
            _banner('⏳ في انتظار رد صاحب العقار...', Colors.orange),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: _sendNewOffer,
            icon: const Icon(Icons.refresh),
            label: const Text(
              'إرسال عرض جديد',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF1B4332),
              side: const BorderSide(color: Color(0xFF1B4332), width: 1.5),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _banner(String msg, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Text(
        msg,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color;
    String label;
    switch (status) {
      case offerAccepted:
        color = Colors.green;
        label = 'مقبول';
        break;
      case offerRejected:
        color = Colors.red;
        label = 'مرفوض';
        break;
      case offerCountered:
        color = Colors.orange;
        label = 'عرض مضاد';
        break;
      default:
        color = Colors.blue;
        label = 'قيد التفاوض';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
