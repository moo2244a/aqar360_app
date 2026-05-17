class AppStrings {
  AppStrings._();

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
  static const String hSearch = 'ابحث عن العقار المناسب';
  static const String sectionPropertyType = 'نوع العقار';
  static const String listingType = 'نوع الإعلان';
  static const String maxPrice = 'أقصى سعر';
  static const String applyFilter = 'تطبيق';

  // ─── Property Type Buttons ───
  static const String typeVilla = 'فيلا';
  static const String typeApartment = 'شقة';
  static const String typeLand = 'أرض';
  static const String all = 'الكل';
  static const String currency = 'جنيه';
  static const String floors = 'طوابق';
  static const String floor = 'دور';
  static const String accountBlocked =
      'تم حظر هذا الحساب، يرجى التواصل مع الدعم';
  static const String noProperties = 'لا توجد عقارات';
  static const String noResultsFor = 'لا توجد نتائج لـ';
  // ─── AppBar ───
  static const String appBarTitle = 'إضافة عقار';

  // ─── Section Titles ───

  static const String sectionPropertyImages = 'صور العقار';
  static const String sectionPropertyDocImages = 'مستندات العقار';
  static const String sectionBasicInfo = 'المعلومات الأساسية';
  static const String sectionOfferType = 'نوع العرض';
  static const String sectionAmenities = 'المرافق';

  // ─── Offer Type Chips ───
  static const String offerForSale = 'للبيع';
  static const String offerForRent = 'للإيجار';

  // ─── Shared Text Fields ───
  static const String fieldPropertyName = 'اسم العقار';
  static const String fieldLocation = 'الموقع / الحي';
  static const String fieldPrice = 'السعر (ج.م)';
  static const String fieldArea = 'المساحة (m²)';
  static const String sectionPropertyDetails = "تفاصيل العقار";
  // ─── Save Button ───
  static const String btnAddProperty = 'إضافة العقار';

  // ════════════════════════════
  //        Villa Strings
  // ════════════════════════════
  static const String sectionVillaDetails = 'تفاصيل الفيلا';

  static const String counterBedrooms = 'غرف النوم';
  static const String counterBathrooms = 'الحمامات';
  static const String counterLivingRooms = 'الصالات';
  static const String counterFloors = 'عدد الأدوار';

  static const String amenityPool = 'مسبح';
  static const String amenityGarden = 'حديقة';
  static const String amenityGarage = 'جراج';

  // ════════════════════════════
  //      Apartment Strings
  // ════════════════════════════
  static const String sectionApartmentDetails = 'تفاصيل الشقة';

  static const String counterFloorNumber = 'رقم الدور';
  static const String counterTotalFloors = 'إجمالي الأدوار';

  static const String amenityElevator = 'أسانسير';
  static const String amenityParking = 'جراج / موقف';
  static const String amenitySecurity = 'أمن وحراسة';
  static const String amenityBalcony = 'بلكونة';

  // ════════════════════════════
  //        Land Strings
  // ════════════════════════════

  static const String sectionZoning = 'تصنيف الأرض';
  static const String sectionLandFeatures = 'خصائص الأرض';
  static const String sectionAvailableServices = 'الخدمات المتاحة';

  static const String fieldStreetWidth = 'عرض الشارع (متر)';

  static const String zoningResidential = 'سكني';
  static const String zoningCommercial = 'تجاري';
  static const String zoningAgricultural = 'زراعي';
  static const String zoningIndustrial = 'صناعي';

  static const List<String> zoningOptions = [
    zoningResidential,
    zoningCommercial,
    zoningAgricultural,
    zoningIndustrial,
  ];

  static const String featureCorner = 'ناصية';
  static const String featureMainStreet = 'شارع رئيسي';

  static const String serviceWater = 'مياه';
  static const String serviceElectricity = 'كهرباء';
  static const String serviceSewage = 'صرف صحي';
  // ════════════════════════════
  //        CompaniesScreen
  // ════════════════════════════
  static const String companiesAndServices = 'الشركات والخدمات';
  static const String myRequests = 'طلباتي';
  static const String noRegisteredCompanies = 'لا توجد شركات مسجلة حالياً.';
  // ════════════════════════════
  //        Add Rfq
  // ════════════════════════════
  static const String projectTitleHint = 'أدخل عنوان المشروع';
  static const String projectTitleLabel = 'عنوان المشروع';

  static const String projectDescHint = 'اكتب تفاصيل المشروع هنا...';
  static const String projectDescLabel = 'التفاصيل';
  static const String submitRequestText = 'تقديم الطلب';
  static const String previousRequestsText = 'طلباتي السابقة';
  static const String noPreviousRequestsText =
      'لم تقم بإرسال أي طلبات حتى الآن';
  static const String viewDetailsText = 'عرض التفاصيل';
}
