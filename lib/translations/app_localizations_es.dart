// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Guardador de Estados';

  @override
  String get statusSaverDescription =>
      'Una Forma Sencilla de Guardar Tus Estados';

  @override
  String get permissionPrompt =>
      'Para Guardar Estados, Necesitas Conceder Permiso';

  @override
  String get grantPermission => 'Conceder Permiso';

  @override
  String get images => 'Imágenes';

  @override
  String get videos => 'Videos';

  @override
  String get saved => 'Guardados';

  @override
  String get language => 'Idioma';

  @override
  String get darkTheme => 'Tema Oscuro';

  @override
  String get howToUse => 'Cómo Usar';

  @override
  String get howToUseDescription =>
      '1. Abre WhatsApp y ve el estado que deseas guardar.\n2. Abre Guardador de Estados y toca el estado que deseas guardar.\n3. Toca el botón de guardar para guardar el estado en tu teléfono.';

  @override
  String get rateUs => 'Califícanos';

  @override
  String get rateUsDescription =>
      'Si te gusta la aplicación, por favor califícanos en la tienda de aplicaciones.';

  @override
  String get share => 'Compartir';

  @override
  String get shareDescription =>
      'Si te gusta la aplicación, por favor compártela con tus amigos y familiares.';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get privacyPolicyDescription =>
      'No recopilamos información personal. No vendemos ni compartimos tu información personal con nadie.';

  @override
  String get contactUs => 'Contáctanos';

  @override
  String get contactUsDescription =>
      'Si tienes alguna pregunta o sugerencia, por favor contáctanos en';

  @override
  String get ok => 'Aceptar';

  @override
  String get cancel => 'Cancelar';
}
