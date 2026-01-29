// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Status Saver';

  @override
  String get statusSaverDescription => 'A Simple Way to Save Your Statuses';

  @override
  String get permissionPrompt =>
      'In Order to Save Statuses, You Need to Grant Permission';

  @override
  String get grantPermission => 'Grant Permission';

  @override
  String get images => 'Images';

  @override
  String get videos => 'Videos';

  @override
  String get saved => 'Saved';

  @override
  String get language => 'Language';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get howToUse => 'How to Use';

  @override
  String get howToUseDescription =>
      '1. Open WhatsApp and view the status you want to save.\n2. Open Status Saver and tap on the status you want to save.\n3. Tap on the save button to save the status to your phone.';

  @override
  String get rateUs => 'Rate Us';

  @override
  String get rateUsDescription =>
      'If you like the app, please rate us on the Play Store';

  @override
  String get share => 'Share';

  @override
  String get shareDescription =>
      'If you like the app, please share it with your friends and family';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get privacyPolicyDescription =>
      'We do not collect any personal information from you. We do not sell or share your personal information with anyone.';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get contactUsDescription =>
      'If you have any questions or suggestions, please contact us at';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';
}
