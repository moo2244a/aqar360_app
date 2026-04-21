/// ملف يحتوي على جميع النصوص المستخدمة في تطبيق عقار 360
/// All text strings used across all screens of the Aqar 360 app

class AppStrings {
  // منع إنشاء نسخة من الكلاس
  AppStrings._();

  // ════════════════════════════════════════════════════════════
  // 🔵 عام — مشترك بين أكتر من شاشة

  /// اسم التطبيق — يظهر في BrandBar في كل الشاشات
  static const String appName = 'Aqar 360';

  /// زر "سجل الدخول" — يظهر في LoginScreen و RegisterScreen و AlreadyHaveAccountComponent
  static const String signInButton = 'سجل الدخول';

  /// جملة "لديك حساب؟ سجل الدخول" — الجزء الأول
  static const String alreadyHaveAccountPrompt = 'لديك حساب بالفعل؟ ';

  /// جملة "ليس لديك حساب؟ سجل الآن" — الجزء الأول
  static const String noAccountPrompt = 'ليس لديك حساب؟ ';

  /// نص زر "سجل الآن" — يظهر في LoginScreen بجانب noAccountPrompt
  static const String registerNowLink = 'سجل الآن';

  /// عنوان قسم "انشاء حساب جديد" — يظهر في AuthSelectionScreen و RegisterFormSection
  static const String createNewAccount = 'انشاء حساب جديد';

  /// رسالة خطأ عامة عند حدوث مشكلة أثناء الإرسال
  static const String genericSendError = 'حدث خطأ أثناء الإرسال';

  // ════════════════════════════════════════════════════════════
  // 🟢 حقول الإدخال المشتركة — تُستخدم في Login و Register و ForgotPassword

  /// تسمية حقل البريد الإلكتروني
  static const String emailFieldLabel = 'البريد الإلكتروني';

  /// نص التلميح داخل حقل البريد الإلكتروني
  static const String emailFieldHint = 'أدخل بريدك الإلكتروني هنا';

  /// تسمية حقل كلمة السر
  static const String passwordFieldLabel = 'كلمة السر';

  /// نص التلميح داخل حقل كلمة السر (نقاط)
  static const String passwordFieldHint = '••••••••';

  /// تسمية حقل الاسم
  static const String nameFieldLabel = 'الاسم';

  /// نص التلميح داخل حقل الاسم
  static const String nameFieldHint = 'أدخل اسمك بالكامل';

  // ════════════════════════════════════════════════════════════
  // 🟡 شاشة الترحيب — WelcomeScreen

  /// السطر الأول من العنوان الرئيسي
  static const String welcomeHeadlinePart1 = 'ابحث عن';

  /// السطر الثاني من العنوان الرئيسي (المميّز بالألوان)
  static const String welcomeHeadlinePart2 = 'الفخامة';

  /// النص الوصفي تحت العنوان
  static const String welcomeSubDescription =
      'اكتشف عالماً جديداً من العقارات\nالاستثنائية التى تتجاوز حدود الخيال';

  /// نص زر الاستكشاف في أسفل الشاشة
  static const String welcomeStartExploreButton = 'ابدأ الاستكشاف';

  // 🟡 شاشة البحث الذكي — SmartOnboardingScreen

  static const String smartOnboardingHeadlinePart1 = 'تقنية ذكية ';

  static const String smartOnboardingHeadlinePart2 = 'للبحث';

  static const String smartOnboardingSubDescription =
      'حلول متطورة تجعل الوصول لمنزلك المستقبلي اسرع';

  // 🟡 شاشة اختيار نوع الحساب — AuthSelectionScreen

  /// السطر الأول من عنوان شاشة اختيار المصادقة
  static const String authSelectionHeadlinePart1 = 'ابدا رحلتك الان';

  /// السطر الثاني — اسم المشروع أو المنطقة
  static const String authSelectionHeadlinePart2 = 'في العاشر من رمضان';

  // ════════════════════════════════════════════════════════════
  // 🟡 شاشة تسجيل الدخول — LoginScreen / LoginFormSection
  // ════════════════════════════════════════════════════════════

  /// عنوان نموذج تسجيل الدخول
  static const String loginFormTitle = 'تسجيل الدخول';

  /// رسالة النجاح بعد تسجيل الدخول بنجاح
  static const String loginSuccessMessage = 'تم تسجيل الدخول بنجاح ';

  /// نص checkbox "تذكرني" في صف خيارات تسجيل الدخول
  static const String rememberMeCheckbox = 'تذكرني';

  /// رابط نسيان كلمة السر
  static const String forgotPasswordLink = 'هل نسيت كلمة السر؟';

  // ════════════════════════════════════════════════════════════
  // 🟡 شاشة نسيت كلمة السر — ForgotPasswordScreen
  // ════════════════════════════════════════════════════════════

  /// عنوان نموذج استعادة كلمة السر
  static const String forgotPasswordFormTitle = 'استعادة كلمة السر';

  /// وصف تعليمي تحت العنوان
  static const String forgotPasswordInstructions =
      'أدخل بريدك الإلكتروني وسيتم إرسال رابط لاستعادة كلمة السر الخاص بك.';

  /// نص زر إرسال رابط الاستعادة
  static const String sendResetLinkButton = 'إرسال الرابط';

  /// رابط "العودة لتسجيل الدخول" أسفل النموذج
  static const String backToLoginLink = 'العودة لتسجيل الدخول';

  /// رسالة النجاح بعد إرسال رابط إعادة تعيين كلمة المرور
  static const String resetPasswordEmailSentMessage =
      'تم إرسال رابط إعادة تعيين كلمة المرور';

  /// رسالة الخطأ عند التحقق من البريد الإلكتروني لإعادة التعيين
  static const String resetPasswordEmailErrorMessage =
      'حدث خطأ، تأكد من البريد الإلكتروني';

  // ════════════════════════════════════════════════════════════
  // 🟡 شاشة إنشاء حساب — RegisterScreen / RegisterFormSection
  // ════════════════════════════════════════════════════════════

  /// عنوان نموذج إنشاء الحساب
  static const String registerFormTitle = 'انشاء حساب جديد';

  // ════════════════════════════════════════════════════════════
  // 🟡 شاشة التحقق من البريد الإلكتروني — VerifyEmailPage
  // ════════════════════════════════════════════════════════════

  /// رسالة تأكيد إرسال بريد التحقق
  static const String verifyEmailSentConfirmation = 'تم إرسال رسالة التحقق  ';
  static const String verifyEmailInstructions =
      'تم إرسال رسالة تأكيد إلى بريدك الإلكتروني\nافتح البريد واضغط على رابط التفعيل';
  // ════════════════════════════════════════════════════════════
  // 🟡— HomePage
  // ════════════════════════════════════════════════════════════
  static const String exploreRealEstate = "استكشف العقارات في";
  static const String tenthOfRamadan = "العاشر من رمضان";
}
