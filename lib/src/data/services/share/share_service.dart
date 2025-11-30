import 'package:flutter/widgets.dart';

abstract interface class ShareService {
  Future<void> copyTextLink(String text);
  Future<void> shareImageTextLink(String imageUrl, String text);
  Future<void> shareQrAsImage({
    required String title,
    required GlobalKey repaintKey,
    String? text,
  });
}
