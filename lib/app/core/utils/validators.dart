class AppValidators {
  // ================= Email =================
  static String? email(String? val) {
    if (val == null || val.isEmpty) {
      return 'من فضلك أدخل البريد الإلكتروني';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(val)) {
      return 'البريد الإلكتروني غير صالح';
    }

    return null;
  }

  // ================= Password =================
  static String? password(String? val) {
    if (val == null || val.isEmpty) {
      return 'من فضلك أدخل كلمة المرور';
    }

    if (val.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }

    return null;
  }

  // ================= Confirm Password =================
  static String? confirmPassword(String? val, String password) {
    if (val == null || val.isEmpty) {
      return 'من فضلك أكد كلمة المرور';
    }

    if (val != password) {
      return 'كلمة المرور غير متطابقة';
    }

    return null;
  }

  // ================= Name =================
  static String? name(String? val) {
    if (val == null || val.isEmpty) {
      return 'من فضلك أدخل الاسم';
    }

    if (val.length < 3) {
      return 'الاسم قصير جدًا';
    }

    return null;
  }
}
