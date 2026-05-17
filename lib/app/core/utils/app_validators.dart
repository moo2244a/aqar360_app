class AppValidators {
  // ================= Email =================
  static String? email(String? val) {
    if (val == null || val.trim().isEmpty) {
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
    if (val == null || val.trim().isEmpty) {
      return 'من فضلك أدخل الاسم';
    }

    if (val.length < 3) {
      return 'الاسم قصير جدًا';
    }

    return null;
  }

  // ─── Required Field ───
  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "من فضلك أدخل $fieldName";
    }
    return null;
  }

  // ─── Number Validator ───
  static String? number(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "من فضلك أدخل $fieldName";
    }
    if (double.tryParse(value) == null) {
      return "$fieldName يجب أن يكون رقم صحيح";
    }
    return null;
  }

  // ─── Price Validator ───
  static String? price(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "من فضلك أدخل السعر";
    }
    final number = double.tryParse(value);
    if (number == null) {
      return "السعر يجب أن يكون رقم";
    }
    if (number <= 0) {
      return "السعر يجب أن يكون أكبر من 0";
    }
    return null;
  }

  // ─── Area Validator ───
  static String? area(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "من فضلك أدخل المساحة";
    }
    final number = double.tryParse(value);
    if (number == null) {
      return "المساحة يجب أن تكون رقم";
    }
    if (number <= 0) {
      return "المساحة يجب أن تكون أكبر من 0";
    }
    return null;
  }

  static String? location(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "من فضلك أدخل الموقع";
    }

    if (value.length < 3) {
      return "الموقع قصير جدًا";
    }

    return null;
  }
}
