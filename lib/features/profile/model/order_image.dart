import 'dart:typed_data';

class OrderImage {
  final Uint8List? bytes;
  final String? url;

  OrderImage({
    this.bytes,
    this.url,
  });

  bool get isMemory => bytes != null;
}
