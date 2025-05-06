// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:my_fome/src/data/services/client/client_service.dart';
import 'package:my_fome/src/data/services/messages/result_message_service.dart';

import './share_service.dart';

class ShareServiceImpl implements ShareService {
  final ClientService clientService;
  final ResultMessageService resultMessageService;
  ShareServiceImpl({
    required this.clientService,
    required this.resultMessageService,
  });

  @override
  Future<void> shareImageTextLink(String imageUrl, String text) async {
    final Response response =
        await clientService.get(imageUrl, responseType: ResponseType.bytes);
    final directory = await getTemporaryDirectory();
    final path = "${directory.path}/image.jpg";
    final file = File(path);
    await file.writeAsBytes(response.data);
    final params = ShareParams(text: text, files: [XFile(path)]);
    await SharePlus.instance.share(params);
  }

  @override
  Future<void> copyTextLink(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    final result = await Clipboard.getData('text/plain');
    if (result != null) {
      resultMessageService.showMessageSuccess(
          TextConstant.successLinkCopiedTitle,
          TextConstant.successLinkCopiedMessage,
          IconConstant.contentCopy);
    }
  }
}
