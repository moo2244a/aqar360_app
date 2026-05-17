import 'package:aqar360/app/core/constants/user_role.dart';
import 'package:aqar360/app/features/addProperty/data/models/apartment_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/land_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/villa_details.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/admin_layout/domain/entities/user_dependencies.dart';
import 'package:aqar360/app/features/admin_layout/domain/usecases/get_data_user_with_id.dart';
import 'package:aqar360/app/features/admin_layout/presentation/widgets/list_view_properties_bloc.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:aqar360/app/core/models/property_offer_model.dart';
import 'package:aqar360/app/features/user_layout/presentation/screens/property_deal_chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/core/constants/property_status.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final PropertyDetails property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  UserModel? userModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    final deps = UserDependencies.create();
    final usecase = GetDataUserWithIdUsecase(
      userRepository: deps.userRepositoryImpl,
    );

    userModel = await usecase.call();

    setState(() {
      isLoading = false;
    });
  }

  // ================== ACTIONS ==================

  void _makeOffer() async {
    final buyerId = FirebaseAuth.instance.currentUser?.uid;
    if (buyerId == null) {
      _snack("لازم تسجل دخول الأول");
      return;
    }
    if (widget.property.ownerId == buyerId) {
      _snack("لا يمكن التفاوض على عقارك");
      return;
    }

    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "تقديم عرض سعر",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "السعر المطلوب: ${widget.property.price?.toStringAsFixed(0)} ج.م",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "عرض السعر (ج.م)",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B4332),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("إرسال العرض"),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true) return;
    final amount = double.tryParse(controller.text.trim());
    if (amount == null || amount <= 0) {
      _snack("مبلغ غير صحيح");
      return;
    }

    final buyerName = userModel?.name ?? 'مشتري';
    final offer = PropertyOfferModel(
      id: '',
      propertyId: widget.property.id ?? '',
      propertyTitle: widget.property.title ?? '',
      buyerId: buyerId,
      buyerName: buyerName,
      ownerId: widget.property.ownerId ?? '',
      offeredPrice: amount,
      isForSale: widget.property.isForSale,
      createdAt: DateTime.now(),
    );

    try {
      await FirebaseHelper.addPropertyOffer(offer);
      _snack("تم إرسال عرضك ✅ سيصلك رد من صاحب العقار");
    } catch (e) {
      _snack("حدث خطأ: $e");
    }
  }

  void _buyDirectly() {
    final buyerId = FirebaseAuth.instance.currentUser?.uid;

    if (buyerId == null) {
      _snack("سجل دخول الأول");
      return;
    }

    if (widget.property.ownerId == buyerId) {
      _snack("هذا عقارك");
      return;
    }

    final actionText = widget.property.isForSale ? "شراء" : "استئجار";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("تأكيد ال$actionText"),
        content: Text(
          "هل تريد $actionText العقار مقابل ${widget.property.price} جنيه؟",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await FirebaseHelper.purchaseOrRentProperty(
                  propertyId: widget.property.id ?? '',
                  buyerId: buyerId,
                  status: widget.property.isForSale
                      ? PropertyStatus.sold
                      : PropertyStatus.rented,
                );
                // Reject any pending offers since it's now sold/rented
                await FirebaseHelper.rejectOtherOffersForProperty(
                  propertyId: widget.property.id ?? '',
                  isForSale: widget.property.isForSale,
                );
                // Initialize deal chat
                await FirebaseHelper.initPropertyDeal(
                  propertyId: widget.property.id ?? '',
                  propertyTitle: widget.property.title ?? '',
                  buyerId: buyerId,
                  ownerId: widget.property.ownerId ?? '',
                  price: widget.property.price ?? 0,
                  isForSale: widget.property.isForSale,
                );
                if (mounted) {
                  _snack("تم ال$actionText بنجاح! ✅");
                  // Navigate to deal chat
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PropertyDealChatScreen(
                        property: widget.property,
                        isBuyer: true,
                      ),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) _snack("حدث خطأ: $e");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B4332),
              foregroundColor: Colors.white,
            ),
            child: Text("تأكيد"),
          ),
        ],
      ),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // ================== UI ==================

  @override
  Widget build(BuildContext context) {
    final p = widget.property;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9F7),
        body: CustomScrollView(
          slivers: [
            _appBar(p),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            p.title ?? "بدون عنوان",
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1B4332),
                              height: 1.3,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B4332).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${p.price} جنيه",
                            style: const TextStyle(
                              color: Color(0xFF1B4332),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            p.location ?? "موقع غير محدد",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "وصف العقار",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _detailsCard(p),
                    const SizedBox(height: 30),
                    const Text(
                      "المواصفات",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _allDetails(p),
                    const SizedBox(height: 100), // padding for bottom bar
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomSheet: _bottomBar(),
      ),
    );
  }

  Widget _appBar(PropertyDetails p) {
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            (p.imagesUrl?.isNotEmpty ?? false)
                ? Image.network(p.imagesUrl!.first, fit: BoxFit.cover)
                : Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.home, size: 80, color: Colors.grey),
                  ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: _badge(
                p.isForSale ? "للبيع" : "للإيجار",
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: Container(
          height: 30,
          decoration: const BoxDecoration(
            color: Color(0xFFF7F9F7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Widget _badge(String text, {required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _detailsCard(PropertyDetails p) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        p.propertyDetails ?? "لا توجد تفاصيل إضافية مسجلة لهذا العقار.",
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
          height: 1.6,
        ),
      ),
    );
  }

  // 🔥 عرض كل البيانات
  Widget _allDetails(PropertyDetails p) {
    List<Widget> items = [
      _infoCard(Icons.aspect_ratio, "المساحة", "${p.area} م²"),
    ];

    if (p is VillaDetails) {
      items.addAll([
        _infoCard(Icons.layers, "الطوابق", "${p.floors}"),
        _infoCard(Icons.bed, "غرف النوم", "${p.bedrooms}"),
        _infoCard(Icons.bathtub, "حمامات", "${p.bathrooms}"),
        _infoCard(Icons.weekend, "ريسيبشن", "${p.livingRooms}"),
        _infoCard(Icons.pool, "مسبح", p.hasPool ? "يوجد" : "لا يوجد"),
        _infoCard(Icons.park, "حديقة", p.hasGarden ? "يوجد" : "لا يوجد"),
      ]);
    } else if (p is ApartmentDetails) {
      items.addAll([
        _infoCard(Icons.stairs, "الدور", "${p.floorNumber}"),
        _infoCard(Icons.bed, "غرف النوم", "${p.bedrooms}"),
        _infoCard(Icons.bathtub, "حمامات", "${p.bathrooms}"),
        _infoCard(Icons.weekend, "ريسيبشن", "${p.livingRooms}"),
        _infoCard(Icons.elevator, "مصعد", p.hasElevator ? "يوجد" : "لا يوجد"),
        _infoCard(Icons.security, "أمن", p.hasSecurity ? "يوجد" : "لا يوجد"),
      ]);
    } else if (p is LandDetails) {
      items.addAll([
        _infoCard(Icons.landscape, "نوع الأرض", p.zoning ?? "غير محدد"),
        _infoCard(Icons.add_road, "عرض الشارع", "${p.streetWidth} متر"),
        _infoCard(Icons.water_drop, "مياه", p.hasWater ? "متوفر" : "غير متوفر"),
        _infoCard(
          Icons.electrical_services,
          "كهرباء",
          p.hasElectricity ? "متوفر" : "غير متوفر",
        ),
      ]);
    }

    return Wrap(
      spacing: 12,
      runSpacing: 16,
      children: items
          .map((e) => FractionallySizedBox(widthFactor: 0.47, child: e))
          .toList(),
    );
  }

  Widget _infoCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1B4332).withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF1B4332), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar() {
    if (isLoading) {
      return Container(
        height: 80,
        color: Colors.white,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (userModel?.role == UserRole.admin) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: PropertyActionButtons(property: widget.property),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton.icon(
                onPressed: _makeOffer,
                icon: const Icon(Icons.handshake),
                label: const Text("تفاوض"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1B4332),
                  side: const BorderSide(color: Color(0xFF1B4332), width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: ElevatedButton.icon(
                onPressed: _buyDirectly,
                icon: const Icon(Icons.shopping_cart),
                label: Text(widget.property.isForSale ? "شراء" : "استئجار"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B4332),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
