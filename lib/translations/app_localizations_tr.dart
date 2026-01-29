// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Durum Saklayıcı';

  @override
  String get statusSaverDescription =>
      'Durumlarınızı saklamak için basit bir yöntem';

  @override
  String get permissionPrompt =>
      'Durumları saklamak için izin vermeniz gerekmektedir';

  @override
  String get grantPermission => 'İzni Ver';

  @override
  String get images => 'Resimler';

  @override
  String get videos => 'Videolar';

  @override
  String get saved => 'Kaydedildi';

  @override
  String get language => 'Dil';

  @override
  String get darkTheme => 'Karanlık Mod';

  @override
  String get howToUse => 'Nasıl Kullanılır';

  @override
  String get howToUseDescription =>
      '1. WhatsApp\'ı açın ve kaydetmek istediğiniz durumu görün.\n2. Durum Saklayıcıyı açın ve kaydetmek istediğiniz duruma tıklayın.\n3. Durumu telefonunuza kaydetmek için kaydet düğmesine basın.';

  @override
  String get rateUs => 'Bize Puan Ver';

  @override
  String get rateUsDescription =>
      'Uygulamayı beğendiyseniz, lütfen Play Mağaza\'da puanlayın.';

  @override
  String get share => 'Paylaş';

  @override
  String get shareDescription =>
      'Eğer uygulama size beğendiyseniz, lütfen arkadaşlarınızla ve ailenizle paylaşın.';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get privacyPolicyDescription =>
      'Kişisel bilgilerinizi toplamıyoruz. Kişisel bilgilerinizi kimseyle satmıyor veya paylaşmıyoruz.';

  @override
  String get contactUs => 'Bizimle İletişime Geçin';

  @override
  String get contactUsDescription =>
      'Herhangi bir sorunuz veya öneriniz varsa, lütfen bize şuradan ulaşın';

  @override
  String get ok => 'Tamam';

  @override
  String get cancel => 'İptal';
}
