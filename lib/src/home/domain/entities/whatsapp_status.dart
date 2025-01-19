import 'dart:io';
import 'dart:typed_data';

class WhatsappStatus {
  final FileSystemEntity file;
  final Uint8List? thumbnail;

  const WhatsappStatus({
    required this.file,
    this.thumbnail,
  });
}
