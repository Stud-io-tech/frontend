// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/app/presentation/controllers/cartItem/cart_item_controller.dart';
import 'package:my_fome/app/presentation/controllers/order/pdf/order_pdf_controller.dart';
import 'package:uikit/uikit.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:my_fome/app/utils/constants/icon_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:my_fome/app/domain/dtos/address/address_detail_dto.dart';
import 'package:my_fome/app/domain/dtos/cartItem/cart_item_group_store_dto.dart';
import 'package:my_fome/app/presentation/controllers/upload/remote/remote_upload_controller.dart';

class OrderPdfScreenWidget extends StatefulWidget {
  final CartItemGroupStoreDto cartItemGroupStoreDto;
  final AddressDetailDto addressUser;
  final String userName;

  const OrderPdfScreenWidget({
    super.key,
    required this.cartItemGroupStoreDto,
    required this.addressUser,
    required this.userName,
  });

  @override
  State<OrderPdfScreenWidget> createState() => _OrderPdfScreenWidgetState();
}

class _OrderPdfScreenWidgetState extends State<OrderPdfScreenWidget> {
  final remoteUploadController = Injector.get<RemoteUploadController>();

  final orderPdfController = Injector.get<OrderPdfController>();

  final cartItemController = Injector.get<CartItemController>();

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await orderPdfController.generate(
        cart: widget.cartItemGroupStoreDto,
        address: widget.addressUser,
        userName: widget.userName);
  }

  @override
  void dispose() {
    orderPdfController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentDefault(
        child: Observer(builder: (context) {
          if (orderPdfController.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!orderPdfController.hasPdf) {
            return Center(
              child: TextHeadlineH2(
                text: TextConstant.errorGenerateOrderPdf,
              ),
            );
          }
          return Column(
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
                  filePath: orderPdfController.pdfPath,
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
          );
        }),
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
                    isLoading: (remoteUploadController.isLoading ||
                        cartItemController.isLoading),
                    text: TextConstant.confirm,
                    onPressed: () async {
                      if (orderPdfController.pdfPath != null) {
                        final urlPDF =
                            await remoteUploadController.uploadOrderPDF(
                                orderPdfController.pdfPath.toString());
                        await cartItemController.approve(
                            widget.addressUser.userId.toString(),
                            widget.cartItemGroupStoreDto.storeId);

                        if (urlPDF != null &&
                            cartItemController.isLoading == false) {
                          launchUrlString(
                              'https://wa.me/${widget.cartItemGroupStoreDto.storeWhatsapp}?text=*Capricha AÍ*%0A%0APEDIDO ${orderPdfController.code}:%0A%0A$urlPDF');
                          context.pop();
                        }
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
