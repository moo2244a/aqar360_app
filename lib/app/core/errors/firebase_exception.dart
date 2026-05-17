import 'package:aqar360/app/core/constants/firebase_error_type.dart';

class FirebaseFireStoreException implements Exception {
  final String message;
  final FirebaseErrorType type;

  const FirebaseFireStoreException._({
    required this.message,
    required this.type,
  });

  // RFQ
  factory FirebaseFireStoreException.addRfq() =>
      const FirebaseFireStoreException._(
        message: 'حدث خطأ أثناء إرسال الطلب.',
        type: FirebaseErrorType.addRfq,
      );

  // Property
  factory FirebaseFireStoreException.addProperty() =>
      const FirebaseFireStoreException._(
        message: 'حدث خطأ أثناء إضافة العقار.',
        type: FirebaseErrorType.addProperty,
      );

  factory FirebaseFireStoreException.updateProperty() =>
      const FirebaseFireStoreException._(
        message: 'تعذر تحديث بيانات العقار.',
        type: FirebaseErrorType.updateProperty,
      );

  // Offers
  factory FirebaseFireStoreException.addOffer() =>
      const FirebaseFireStoreException._(
        message: 'حدث خطأ أثناء إرسال عرض السعر.',
        type: FirebaseErrorType.addOffer,
      );

  factory FirebaseFireStoreException.respondOffer() =>
      const FirebaseFireStoreException._(
        message: 'تعذر الرد على العرض.',
        type: FirebaseErrorType.respondOffer,
      );

  // Notifications
  factory FirebaseFireStoreException.notification() =>
      const FirebaseFireStoreException._(
        message: 'حدث خطأ أثناء إرسال الإشعار.',
        type: FirebaseErrorType.notification,
      );

  // Chat

  factory FirebaseFireStoreException.sendMessage() =>
      const FirebaseFireStoreException._(
        message: 'تعذر إرسال الرسالة.',
        type: FirebaseErrorType.sendMessage,
      );

  factory FirebaseFireStoreException.unknown([String? details]) =>
      FirebaseFireStoreException._(
        message: 'حدث خطأ غير متوقع.${details != null ? ' $details' : ''}',
        type: FirebaseErrorType.unknown,
      );

  @override
  String toString() => message;
}
