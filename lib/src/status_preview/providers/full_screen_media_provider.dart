import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/src/home/domain/entities/whatsapp_status.dart';

final fullScreenMediaProvider = Provider<FullScreenMediaProvider>((ref) {
  return FullScreenMediaProvider();
});

class FullScreenMediaProvider {
  bool isStatusSaved = false;
  int index = 0;
  List<WhatsappStatus> media = [];

  void setMedia(
    List<WhatsappStatus> media,
    int index,
    bool? isStatusSaved,
  ) {
    this.media = media;
    this.index = index;
    this.isStatusSaved = isStatusSaved ?? this.isStatusSaved;
  }
}
