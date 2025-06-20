// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/ui/controllers/upload/remote/remote_upload_controller.dart';

class OrderPdfScreenWidget extends StatelessWidget {
  final String path;
  final String whatsapp;
  final String code;

  OrderPdfScreenWidget({
    super.key,
    required this.path,
    required this.whatsapp,
    required this.code,
  });

  final remoteUploadController = Injector.get<RemoteUploadController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentDefault(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: SizeToken.xl3,
            ),
            Row(
              spacing: SizeToken.sm,
              children: [
                IconButtonLargeDark(
                  onTap: () => context.pop(),
                  icon: IconConstant.arrowLeft,
                ),
                TextLabelL1Dark(text: TextConstant.orderConfirmation)
              ],
            ),
            const SizedBox(height: SizeToken.sm),
            Expanded(
              child: PDFView(
                filePath: path,
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: true,
                pageFling: true,
                onError: (error) {
                  debugPrint('Erro ao abrir PDF: $error');
                },
                onRender: (pages) {
                  debugPrint('PDF renderizado com $pages páginas.');
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        color: ColorToken.light,
        padding: const EdgeInsets.symmetric(
            horizontal: SizeToken.md, vertical: SizeToken.xxs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: ButtonCancel(
              text: TextConstant.cancel,
              onPressed: () => context.pop(),
            )),
            const SizedBox(
              width: SizeToken.sm,
            ),
            Expanded(
              child: Observer(builder: (context) {
                return ButtonProgress(
                    isLoading: remoteUploadController.isLoading,
                    text: TextConstant.confirm,
                    onPressed: () async {
                      final urlPDF =
                          await remoteUploadController.uploadOrderPDF(path);
                      if (urlPDF != null) {
                        launchUrlString(
                            'https://wa.me/$whatsapp?text=*Capricha AÍ*%0A%0APEDIDO $code:%0A%0A$urlPDF');
                      }
                    });
              }),
            )
          ],
        ),
      ),
    );
  }
}
