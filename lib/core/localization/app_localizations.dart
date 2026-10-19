import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // Common & Navigation
      'app_name': 'Doctor Hunt',
      'home': 'Home',
      'favourites': 'Favourites',
      'appointments': 'Appointments',
      'settings': 'Settings',

      // Settings Screen
      'account_settings': 'Account settings',
      'change_password': 'Change Password',
      'notifications': 'Notifications',
      'privacy_policy': 'Privacy Policy',
      'more_options': 'More options',
      'languages': 'Languages',
      'build_version': 'Build version',
      'logout': 'Logout',
      'logout_dialog_title': 'Log Out',
      'logout_dialog_desc': 'Are you sure you want to logout?',
      'cancel': 'Cancel',
      'ok': 'Ok',
      'select_language': 'Select Language',
      'current_language': 'English',

      // Profile Screen
      'profile': 'Profile',
      'personal_information': 'Personal information',
      'name': 'Name',
      'contact_number': 'Contact Number',
      'continue_btn': 'Continue',
      'profile_updated': 'Profile updated successfully!',

      // Home Screen
      'home_greeting': 'Hi menna!',
      'find_your_doctor': 'Find Your Doctor',
      'search_hint': 'Search.....',
      'live_doctors': 'Live Doctors',
      'popular_doctor': 'Popular Doctor',
      'feature_doctor': 'Feature Doctor',
      'see_all': 'See all ›',

      // Doctors & Search
      'find_doctors': 'Find Doctors',
      'favourite_doctors': 'Favourite Doctors',
      'search_doctor_hint': 'Search doctor or specialty...',
      'no_favourite_doctors': 'No favourite doctors yet',
      'no_matching_doctors': 'No matching favourite doctors',
      'click_heart_to_add':
          'Click the heart icon on any doctor to add them here',
      'try_searching_again': 'Try searching with another name or specialty',
      'book_now': 'Book Now',
      'next_available': 'Next Available',
      'years_experience': 'Years experience',

      // Appointments
      'upcoming': 'Upcoming',
      'completed': 'Completed',
      'cancelled': 'Cancelled',
      'cancel_appointment': 'Cancel',
      'reschedule': 'Reschedule',
      'rebook': 'Re-Book',

      // Change Password Sheet
      'current_password': 'Current Password',
      'new_password': 'New Password',
      'confirm_new_password': 'Confirm New Password',
      'update_password': 'Update Password',
      'password_updated': 'Password updated successfully!',
      'passwords_not_match': 'Passwords do not match',
    },
    'ar': {
      // Common & Navigation
      'app_name': 'دكتور هانت',
      'home': 'الرئيسية',
      'favourites': 'المفضلة',
      'appointments': 'مواعيدي',
      'settings': 'الإعدادات',

      // Settings Screen
      'account_settings': 'إعدادات الحساب',
      'change_password': 'تغيير كلمة المرور',
      'notifications': 'الإشعارات',
      'privacy_policy': 'سياسة الخصوصية',
      'more_options': 'خيارات إضافية',
      'languages': 'اللغات',
      'build_version': 'إصدار التطبيق',
      'logout': 'تسجيل الخروج',
      'logout_dialog_title': 'تسجيل الخروج',
      'logout_dialog_desc': 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
      'cancel': 'إلغاء',
      'ok': 'موافق',
      'select_language': 'اختر اللغة',
      'current_language': 'العربية',

      // Profile Screen
      'profile': 'الملف الشخصي',
      'personal_information': 'المعلومات الشخصية',
      'name': 'الاسم',
      'contact_number': 'رقم الهاتف',
      'continue_btn': 'متابعة',
      'profile_updated': 'تم تحديث الملف الشخصي بنجاح!',

      // Home Screen
      'home_greeting': 'أهلاً منة!',
      'find_your_doctor': 'ابحث عن طبيبك',
      'search_hint': 'بحث.....',
      'live_doctors': 'الأطباء المتاحون الآن',
      'popular_doctor': 'الأطباء الأكثر طلباً',
      'feature_doctor': 'أطباء مميزون',
      'see_all': 'عرض الكل ‹',

      // Doctors & Search
      'find_doctors': 'البحث عن الأطباء',
      'favourite_doctors': 'الأطباء المفضلون',
      'search_doctor_hint': 'ابحث عن طبيب أو تخصص...',
      'no_favourite_doctors': 'لا يوجد أطباء مفضلون حتى الآن',
      'no_matching_doctors': 'لا توجد نتائج مطابقة في المفضلة',
      'click_heart_to_add':
          'اضغط على القلب بجانب أي طبيب لإضافته إلى المفضلة',
      'try_searching_again': 'جرب البحث باسم أو تخصص آخر',
      'book_now': 'احجز الآن',
      'next_available': 'الموعد المتاح',
      'years_experience': 'سنوات خبرة',

      // Appointments
      'upcoming': 'القادمة',
      'completed': 'المكتملة',
      'cancelled': 'الملغاة',
      'cancel_appointment': 'إلغاء الموعد',
      'reschedule': 'تغيير الموعد',
      'rebook': 'إعادة الحجز',

      // Change Password Sheet
      'current_password': 'كلمة المرور الحالية',
      'new_password': 'كلمة المرور الجديدة',
      'confirm_new_password': 'تأكيد كلمة المرور الجديدة',
      'update_password': 'تحديث كلمة المرور',
      'password_updated': 'تم تحديث كلمة المرور بنجاح!',
      'passwords_not_match': 'كلمات المرور غير متطابقة',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension LocalizationExtension on BuildContext {
  String tr(String key) => AppLocalizations.of(this).translate(key);
  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';
}
