import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aqar360/app/core/models/property_offer_model.dart';
import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/user_layout/presentation/screens/property_deal_chat_screen.dart';
import 'package:aqar360/app/features/user_layout/presentation/screens/property_negotiation_screen.dart';

class MyPurchasesScreen extends StatelessWidget {
  const MyPurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F9F7),
          appBar: AppBar(
            title: const Text(
              'عقاراتي',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              labelColor: Color(0xFF1B4332),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF1B4332),
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              tabs: [
                Tab(icon: Icon(Icons.home_outlined, size: 20), text: 'عقاراتي'),
                Tab(icon: Icon(Icons.send_outlined, size: 20), text: 'عروضي'),
                Tab(icon: Icon(Icons.inbox_outlined, size: 20), text: 'وصلني'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _PurchasedTab(uid: uid),
              _SentOffersTab(uid: uid),
              _ReceivedOffersTab(uid: uid),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// TAB 1: Purchased / Rented Properties
// ═══════════════════════════════════════════
class _PurchasedTab extends StatelessWidget {
  final String uid;
  const _PurchasedTab({required this.uid});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: const TabBar(
              labelColor: Color(0xFF1B4332),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF1B4332),
              tabs: [
                Tab(text: 'اشتريتها / استأجرتها'),
                Tab(text: 'بعتها / أجرتها'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _PropertyList(
                  stream: FirebaseHelper.getUserPurchasedProperties(),
                  uid: uid,
                  isBuyerTab: true,
                  emptyMsg: 'لم تشترِ أو تستأجر أي عقار بعد',
                ),
                _PropertyList(
                  stream: FirebaseHelper.getOwnerDeals(),
                  uid: uid,
                  isBuyerTab: false,
                  emptyMsg: 'لم تبع أو تؤجر أي عقار بعد',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// TAB 2: Sent Offers (Buyer)
// ═══════════════════════════════════════════
class _SentOffersTab extends StatelessWidget {
  final String uid;
  const _SentOffersTab({required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PropertyOfferModel>>(
      stream: FirebaseHelper.getBuyerOffers(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final offers = snapshot.data ?? [];
        if (offers.isEmpty) {
          return _EmptyState(
            icon: Icons.send_outlined,
            msg: 'لم ترسل أي عرض على عقار بعد',
            sub: 'تفاوض على عقار من الصفحة الرئيسية',
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: offers.length,
          itemBuilder: (_, i) => _OfferCard(offer: offers[i], isBuyer: true),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════
// TAB 3: Received Offers (Owner)
// ═══════════════════════════════════════════
class _ReceivedOffersTab extends StatelessWidget {
  final String uid;
  const _ReceivedOffersTab({required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PropertyOfferModel>>(
      stream: FirebaseHelper.getOwnerReceivedOffers(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final offers = snapshot.data ?? [];
        if (offers.isEmpty) {
          return _EmptyState(
            icon: Icons.inbox_outlined,
            msg: 'لا توجد عروض على عقاراتك بعد',
            sub: 'ستظهر هنا عروض المشترين',
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: offers.length,
          itemBuilder: (_, i) => _OfferCard(offer: offers[i], isBuyer: false),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════
// Offer Card
// ═══════════════════════════════════════════
class _OfferCard extends StatelessWidget {
  final PropertyOfferModel offer;
  final bool isBuyer;
  const _OfferCard({required this.offer, required this.isBuyer});

  Color get _statusColor {
    switch (offer.status) {
      case offerAccepted:
        return Colors.green;
      case offerRejected:
        return Colors.red;
      case offerCountered:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  String get _statusLabel {
    switch (offer.status) {
      case offerAccepted:
        return 'مقبول ✅';
      case offerRejected:
        return 'مرفوض ❌';
      case offerCountered:
        return 'عرض مضاد 🔄';
      default:
        return 'قيد التفاوض ⏳';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PropertyNegotiationScreen(offer: offer),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _statusColor.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B4332).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.home,
                      color: Color(0xFF1B4332),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      offer.propertyTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF1B4332),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _statusLabel,
                      style: TextStyle(
                        color: _statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _infoChip(
                    Icons.attach_money,
                    'عرضك: ${offer.offeredPrice.toStringAsFixed(0)} ج.م',
                    Colors.blue,
                  ),
                  if (offer.counterPrice != null) ...[
                    const SizedBox(width: 8),
                    _infoChip(
                      Icons.swap_horiz,
                      'مضاد: ${offer.counterPrice!.toStringAsFixed(0)} ج.م',
                      Colors.orange,
                    ),
                  ],
                ],
              ),
              if (!isBuyer) ...[
                const SizedBox(height: 8),
                Text(
                  'من: ${offer.buyerName}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B4332),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.open_in_new, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'عرض التفاصيل',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// Property List (for tab 1)
// ═══════════════════════════════════════════
class _PropertyList extends StatelessWidget {
  final Stream<List<PropertyDetails>> stream;
  final String uid;
  final bool isBuyerTab;
  final String emptyMsg;
  const _PropertyList({
    required this.stream,
    required this.uid,
    required this.isBuyerTab,
    required this.emptyMsg,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PropertyDetails>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final properties = snapshot.data ?? [];
        if (properties.isEmpty) {
          return _EmptyState(
            icon: Icons.home_outlined,
            msg: emptyMsg,
            sub: 'تصفح العقارات وابدأ رحلتك العقارية',
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: properties.length,
          itemBuilder: (ctx, i) {
            final p = properties[i];
            final isBuyer = p.buyerId == uid;
            return _PropertyDealCard(property: p, isBuyer: isBuyer);
          },
        );
      },
    );
  }
}

// ═══════════════════════════════════════════
// Property Deal Card
// ═══════════════════════════════════════════
class _PropertyDealCard extends StatelessWidget {
  final PropertyDetails property;
  final bool isBuyer;
  const _PropertyDealCard({required this.property, required this.isBuyer});

  @override
  Widget build(BuildContext context) {
    final p = property;
    final dealLabel = p.isForSale ? 'مباع' : 'مؤجر';
    final dealColor = p.isForSale
        ? Colors.blue.shade700
        : Colors.orange.shade700;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PropertyDealChatScreen(property: p, isBuyer: isBuyer),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  (p.imagesUrl?.isNotEmpty ?? false)
                      ? Image.network(
                          p.imagesUrl!.first,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 150,
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.home,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _badge(dealLabel, dealColor),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: _badge(
                      isBuyer ? 'أنت المشتري' : 'أنت البائع',
                      Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.title ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF1B4332),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'سعر الاتفاق: ${(p.agreedPrice ?? p.price)?.toStringAsFixed(0)} ج.م',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B4332),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 14,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'المحادثة',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String text, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 11,
      ),
    ),
  );
}

// ═══════════════════════════════════════════
// Empty State
// ═══════════════════════════════════════════
class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String msg;
  final String sub;
  const _EmptyState({required this.icon, required this.msg, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 70, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            msg,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
