import 'dart:convert';

import 'package:aqar360/app/core/constants/property_status.dart';
import 'package:aqar360/app/core/constants/user_role.dart';
import 'package:aqar360/app/core/errors/auth_exception.dart' show AuthException;
import 'package:aqar360/app/core/errors/firebase_exception.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';
import 'package:aqar360/app/core/models/rfq_message_model.dart';
import 'package:aqar360/app/core/models/notification_model.dart';
import 'package:aqar360/app/core/models/property_offer_model.dart';
import 'package:aqar360/app/core/models/property_deal_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class FirebaseHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static Future<UserModel> signInWithEmailAndPassword(
    UserModel userModel,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );

      final user = userCredential.user!;
      final doc = await _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .get();

      final data = doc.data();
      return UserModel(
        email: user.email!,
        role: fromJson(data!["role"]),
        name: user.displayName,
        isBlock: data["isBlock"],
        password: userModel.password,
        emailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  static Future<UserModel> createUserWithEmailAndPassword(
    UserModel user,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await userCredential.user?.updateDisplayName(user.name);
      await _firebaseFirestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .set(user.toJson());
      return UserModel(
        email: user.email,

        emailVerified: user.emailVerified,
        password: user.password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    }
  }

  static Exception _mapFirebaseException(FirebaseAuthException e) {
    return switch (e.code) {
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => AuthException.invalidCredentials(),
      'email-already-in-use' => AuthException.emailAlreadyInUse(),
      'weak-password' => AuthException.weakPassword(),
      'network-request-failed' => AuthException.networkError(),
      'too-many-requests' => AuthException.tooManyRequests(),
      _ => AuthException.unknown(e.message),
    };
  }

  static Future<void> addProperty(PropertyDetails propertyModel) async {
    propertyModel.ownerId = _auth.currentUser!.uid;
    propertyModel.agreedPrice = propertyModel.agreedPrice;
    await _firebaseFirestore
        .collection('properties')
        .add(propertyModel.toJson());
  }

  static Future<List<PropertyDetails>> getPendingProperties() async {
    final querySnapshot = await _firebaseFirestore
        .collection('properties')
        .where('status', isEqualTo: PropertyStatus.pending.name)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return PropertyDetails.fromJson(data);
    }).toList();
  }

  static Stream<List<PropertyDetails>> getActiveProperties() {
    return _firebaseFirestore
        .collection('properties')
        .where('status', isEqualTo: PropertyStatus.active.name)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return PropertyDetails.fromJson(data);
          }).toList(),
        );
  }

  static Future<void> updatePropertyStatus({
    required String propertyId,
    required PropertyStatus status,
    String? rejectionReason,
  }) async {
    final Map<String, dynamic> updateData = {'status': status.name};
    if (rejectionReason != null) {
      updateData['rejectionReason'] = rejectionReason;
    }
    await _firebaseFirestore
        .collection('properties')
        .doc(propertyId)
        .update(updateData);
  }

  static Future<PropertyDetails?> getPropertyById(String propertyId) async {
    final doc = await _firebaseFirestore
        .collection('properties')
        .doc(propertyId)
        .get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    data['id'] = doc.id;
    return PropertyDetails.fromJson(data);
  }

  static Future<void> updateProperty(PropertyDetails property) async {
    if (property.id == null) return;
    await _firebaseFirestore
        .collection('properties')
        .doc(property.id)
        .update(property.toJson());
  }

  static Future<void> purchaseOrRentProperty({
    required String propertyId,
    required String buyerId,
    required PropertyStatus status, // sold or rented
    double? agreedPrice,
  }) async {
    await _firebaseFirestore.collection('properties').doc(propertyId).update({
      'status': status.name,
      'buyerId': buyerId,
      if (agreedPrice != null) 'agreedPrice': agreedPrice,
    });
  }

  static Future<List<UserModel>> getAllUsers() async {
    final querySnapshot = await _firebaseFirestore.collection('users').get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return UserModel(
        id: doc.id,
        email: data['email'] ?? '',
        password: '', // We don't fetch passwords
        name: data['name'],
        isBlock: data['isBlock'] ?? false,
        role: data['role'] != null ? fromJson(data['role']) : UserRole.user,
      );
    }).toList();
  }

  static Future<void> updateUserBlockStatus(String uid, bool isBlock) async {
    await _firebaseFirestore.collection('users').doc(uid).update({
      'isBlock': isBlock,
    });
  }

  static Future<UserModel?> getDataUserWithId() async {
    try {
      final user = _auth.currentUser!;
      final doc = await _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .get();

      final data = doc.data();
      if (doc.exists) {
        return UserModel(
          email: user.email!,
          role: fromJson(data!["role"]),
          name: user.displayName,
          isBlock: data["isBlock"],
          password: " ",
          emailVerified: user.emailVerified,
        );
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error fetching user: $e");
    }
  }

  // --- Services (RFQs & Companies) ---

  static Future<List<UserModel>> getCompanies() async {
    final querySnapshot = await _firebaseFirestore
        .collection('users')
        .where('role', isEqualTo: 'company')
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return UserModel(
        id: doc.id,
        email: data['email'],
        password: '',
        name: data['name'],
        isBlock: data['isBlock'] ?? false,
        role: UserRole.company,
      );
    }).toList();
  }

  static Future<void> addRfq(RfqModel rfq) async {
    try {
      final docRef = _firebaseFirestore.collection('rfqs').doc();
      rfq.id = docRef.id;
      rfq.userId = _auth.currentUser!.uid;
      await docRef.set(rfq.toMap());
    } catch (e) {
      throw FirebaseFireStoreException.addRfq();
    }
  }

  static Stream<List<RfqModel>> getCompanyRfqs(String companyId) {
    return _firebaseFirestore
        .collection('rfqs')
        .where('companyId', isEqualTo: companyId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RfqModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  static Stream<List<RfqModel>> getUserRfqs() {
    final userId = _auth.currentUser!.uid;
    return _firebaseFirestore
        .collection('rfqs')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RfqModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  static Future<void> updateRfqStatus(String rfqId, String status) async {
    await _firebaseFirestore.collection('rfqs').doc(rfqId).update({
      'status': status,
    });
  }

  static Future<void> updateRfqWithQuote({
    required String rfqId,
    required double quotedPrice,
    required String companyNote,
    required String userId,
    required String projectTitle,
  }) async {
    await _firebaseFirestore.collection('rfqs').doc(rfqId).update({
      'status': 'quoted',
      'quotedPrice': quotedPrice,
      'companyNote': companyNote,
    });
    // Notify user
    await addNotification(
      NotificationModel(
        id: '',
        userId: userId,
        title: 'عرض سعر جديد على طلبك',
        body:
            'شركة أرسلت لك عرض سعر على طلب "$projectTitle" بقيمة ${quotedPrice.toStringAsFixed(0)} ج.م',
        createdAt: DateTime.now(),
        type: 'rfq_quoted',
        relatedId: rfqId,
      ),
    );
  }

  static Future<void> respondToRfqQuote({
    required String rfqId,
    required bool accepted,
    required String companyId,
    required String projectTitle,
  }) async {
    final status = accepted ? 'user_approved' : 'user_rejected';
    await _firebaseFirestore.collection('rfqs').doc(rfqId).update({
      'status': status,
    });
    // Notify company
    await addNotification(
      NotificationModel(
        id: '',
        userId: companyId,
        title: accepted ? 'تم قبول عرض السعر' : 'تم رفض عرض السعر',
        body: accepted
            ? 'قبل العميل عرض سعرك على طلب "$projectTitle"'
            : 'رفض العميل عرض سعرك على طلب "$projectTitle"',
        createdAt: DateTime.now(),
        type: accepted ? 'quote_accepted' : 'quote_rejected',
        relatedId: rfqId,
      ),
    );
  }

  // --- RFQ Chat ---

  static Future<void> addRfqMessage(
    String rfqId,
    RfqMessageModel message,
  ) async {
    final docRef = _firebaseFirestore
        .collection('rfqs')
        .doc(rfqId)
        .collection('messages')
        .doc();
    message.id = docRef.id;
    await docRef.set(message.toMap());
  }

  static Stream<List<RfqMessageModel>> getRfqMessages(String rfqId) {
    return _firebaseFirestore
        .collection('rfqs')
        .doc(rfqId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RfqMessageModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  // --- Notifications ---

  static Future<void> addNotification(NotificationModel notification) async {
    final docRef = _firebaseFirestore.collection('notifications').doc();
    notification.id = docRef.id;
    await docRef.set(notification.toMap());
  }

  static Stream<List<NotificationModel>> getUserNotifications(String userId) {
    return _firebaseFirestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => NotificationModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  static Future<void> markNotificationAsRead(String notificationId) async {
    await _firebaseFirestore
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }

  // --- Property Offers (Price Negotiation) ---

  static Future<void> addPropertyOffer(PropertyOfferModel offer) async {
    final docRef = _firebaseFirestore.collection('property_offers').doc();
    offer.id = docRef.id;
    await docRef.set(offer.toMap());
    // Notify owner
    await addNotification(
      NotificationModel(
        id: '',
        userId: offer.ownerId,
        title: 'عرض سعر جديد على عقارك!',
        body:
            '${offer.buyerName} يعرض ${offer.offeredPrice.toStringAsFixed(0)} ج.م على عقارك.',
        createdAt: DateTime.now(),
        type: 'property_offer',
        relatedId: offer.propertyId,
      ),
    );
  }

  static Stream<List<PropertyOfferModel>> getPropertyOffers(String propertyId) {
    return _firebaseFirestore
        .collection('property_offers')
        .where('propertyId', isEqualTo: propertyId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (s) => s.docs
              .map((d) => PropertyOfferModel.fromMap(d.data(), d.id))
              .toList(),
        );
  }

  static Stream<List<PropertyOfferModel>> getBuyerOffers(String buyerId) {
    return _firebaseFirestore
        .collection('property_offers')
        .where('buyerId', isEqualTo: buyerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (s) => s.docs
              .map((d) => PropertyOfferModel.fromMap(d.data(), d.id))
              .toList(),
        );
  }

  static Stream<List<PropertyOfferModel>> getOwnerReceivedOffers(
    String ownerId,
  ) {
    return _firebaseFirestore
        .collection('property_offers')
        .where('ownerId', isEqualTo: ownerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (s) => s.docs
              .map((d) => PropertyOfferModel.fromMap(d.data(), d.id))
              .toList(),
        );
  }

  static Future<void> respondToPropertyOffer({
    required String offerId,
    required bool accepted,
    required String buyerId,
    required String buyerName,
    double? counterPrice,
    String? ownerNote,
  }) async {
    final status = accepted
        ? offerAccepted
        : (counterPrice != null ? offerCountered : offerRejected);
    await _firebaseFirestore.collection('property_offers').doc(offerId).update({
      'status': status,
      if (counterPrice != null) 'counterPrice': counterPrice,
      if (ownerNote != null) 'ownerNote': ownerNote,
    });
    // Notify buyer
    await addNotification(
      NotificationModel(
        id: '',
        userId: buyerId,
        title: accepted
            ? 'تم قبول عرض سعرك!'
            : (counterPrice != null
                  ? 'عرض مضاد من صاحب العقار'
                  : 'تم رفض عرضك'),
        body: accepted
            ? 'وافق صاحب العقار على عرض سعرك. تواصل معه لإتمام الصفقة.'
            : counterPrice != null
            ? 'صاحب العقار يقترح سعر ${counterPrice.toStringAsFixed(0)} ج.م ${ownerNote != null ? "- $ownerNote" : ""}'
            : 'رفض صاحب العقار عرض سعرك${ownerNote != null ? ": $ownerNote" : ""}.',
        createdAt: DateTime.now(),
        type: accepted
            ? 'offer_accepted'
            : (counterPrice != null ? 'offer_countered' : 'offer_rejected'),
        relatedId: offerId,
      ),
    );
  }

  static Future<void> rejectOtherOffersForProperty({
    required String propertyId,
    String? acceptedOfferId,
    required bool isForSale,
  }) async {
    final reason = isForSale
        ? 'تم بيع العقار لمشترٍ آخر'
        : 'تم تأجير العقار لمستأجر آخر';

    // Get all offers for this property
    final snapshot = await _firebaseFirestore
        .collection('property_offers')
        .where('propertyId', isEqualTo: propertyId)
        .get();

    final batch = _firebaseFirestore.batch();
    final notifications = <NotificationModel>[];

    for (var doc in snapshot.docs) {
      if (acceptedOfferId != null && doc.id == acceptedOfferId) continue;

      final status = doc.data()['status'] as String?;
      // Only reject offers that are pending or countered
      if (status == offerPending || status == offerCountered) {
        batch.update(doc.reference, {
          'status': offerRejected,
          'ownerNote': reason,
        });

        final buyerId = doc.data()['buyerId'] as String?;
        if (buyerId != null) {
          notifications.add(
            NotificationModel(
              id: '',
              userId: buyerId,
              title: 'تم إغلاق العرض',
              body: 'تم رفض عرضك لأن $reason.',
              createdAt: DateTime.now(),
              type: 'offer_rejected',
              relatedId: doc.id,
            ),
          );
        }
      }
    }

    await batch.commit();

    // Send notifications
    for (var notif in notifications) {
      await addNotification(notif);
    }
  }

  // --- Property Deal Chat (Buyer ↔ Seller) ---

  /// chatId = propertyId (unique per property deal)
  static Future<void> sendDealMessage(
    String propertyId,
    PropertyDealMessage msg,
  ) async {
    await _firebaseFirestore
        .collection('property_deals')
        .doc(propertyId)
        .collection('messages')
        .add(msg.toMap());
  }

  static Stream<List<PropertyDealMessage>> getDealMessages(String propertyId) {
    return _firebaseFirestore
        .collection('property_deals')
        .doc(propertyId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map(
          (s) => s.docs
              .map((d) => PropertyDealMessage.fromMap(d.data(), d.id))
              .toList(),
        );
  }

  /// Initialize deal document when property is purchased/rented
  static Future<void> initPropertyDeal({
    required String propertyId,
    required String propertyTitle,
    required String buyerId,
    required String ownerId,
    required double price,
    required bool isForSale,
  }) async {
    await _firebaseFirestore.collection('property_deals').doc(propertyId).set({
      'propertyId': propertyId,
      'propertyTitle': propertyTitle,
      'buyerId': buyerId,
      'ownerId': ownerId,
      'price': price,
      'dealType': isForSale ? 'sale' : 'rent',
      'createdAt': Timestamp.fromDate(DateTime.now()),
    }, SetOptions(merge: true));
  }

  /// Get all deals where current user is buyer OR seller (owner)
  static Stream<List<PropertyDetails>> getUserPurchasedProperties() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Stream.empty();
    // Stream buyer deals
    return _firebaseFirestore
        .collection('properties')
        .where('buyerId', isEqualTo: uid)
        .snapshots()
        .map(
          (s) => s.docs
              .map((d) => PropertyDetails.fromJson({...d.data(), 'id': d.id}))
              .toList(),
        );
  }

  /// Get deals where user is the OWNER (sold/rented their properties)
  static Stream<List<PropertyDetails>> getOwnerDeals() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return _firebaseFirestore
        .collection('properties')
        .where('ownerId', isEqualTo: uid)
        .where('status', whereIn: ['sold', 'rented'])
        .snapshots()
        .map(
          (s) => s.docs
              .map((d) => PropertyDetails.fromJson({...d.data(), 'id': d.id}))
              .toList(),
        );
  }

  Future<void> sendNotification() async {
    // 1. جيب الـ Firebase Token
    const String _baseUrl =
        'https://push-notification-service-ashen.vercel.app';
    final user = FirebaseAuth.instance.currentUser;
    final firebaseToken = await user?.getIdToken(true);

    if (firebaseToken == null) {
      print("User not logged in");
      return;
    }

    // 2. ابعت الـ request
    final response = await http.post(
      Uri.parse('$_baseUrl/send-notification'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'your-api-key',
        'Authorization': 'Bearer $firebaseToken',
      },
      body: jsonEncode({
        "message": {
          "topic": "all",
          "data": {"type": "chat", "id": "10"},
          "notification": {"title": "FCM Message", "body": "This is a test"},
        },
      }),
    );

    print(response.body);
  }
}
