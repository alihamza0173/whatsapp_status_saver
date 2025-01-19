import 'dart:io';

enum StatusDirectory {
  whatsapp,
  whatsappBusiness,
  savedStatus,
}

extension WhatsappStatusDirExtension on StatusDirectory {
  Directory get directory {
    switch (this) {
      case StatusDirectory.whatsappBusiness:
        return Directory(
          '/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses',
        );
      case StatusDirectory.whatsapp:
        return Directory(
          '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses',
        );
      case StatusDirectory.savedStatus:
        return Directory(
          '/storage/emulated/0/Download/StatusSaver',
        );
    }
  }
}
