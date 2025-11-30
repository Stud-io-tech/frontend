// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/constants/deep_link_constant.dart';
import 'package:my_fome/src/constants/image_error_constant.dart';
import 'package:my_fome/src/data/services/share/share_service.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';
import 'package:my_fome/src/ui/controllers/product/product_controller.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/modules/home/widgets/alert/alert_order.dart';
import 'package:my_fome/src/ui/modules/home/widgets/screens/store_detail_screen_widget.dart';

class ProductDetailScreenWidget extends StatefulWidget {
  final ProductDetailDto? productModel;
  final String? id;
  const ProductDetailScreenWidget({
    super.key,
    this.productModel,
    this.id,
  });

  @override
  State<ProductDetailScreenWidget> createState() =>
      _ProductDetailScreenWidgetState();
}

class _ProductDetailScreenWidgetState extends State<ProductDetailScreenWidget> {
  final productController = Injector.get<ProductController>();
  final storeController = Injector.get<StoreController>();
  final shareService = Injector.get<ShareService>();
  late ProductDetailDto product;
  static final GlobalKey repaintKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      productController.detailProduct(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        if (widget.id != null && productController.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (widget.id != null) {
          product = productController.product!;
        } else {
          product = widget.productModel!;
        }

        storeController.detailStore(product.storeId);
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageDetail(
                image: product.image,
                iconLeft: IconConstant.arrowLeft,
                onTapIconLeft: () =>
                    widget.id != null ? context.push('/') : context.pop(),
                widgetRigth: PopUpMenuShare(
                  menuIcon: IconConstant.share,
                  secoundIcon: IconConstant.qrcode,
                  secoundLabel: TextConstant.shareQRCode,
                  secoundOnTap: () {
                    showCustomModalBottomSheet(
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (context) => ModalSheetQrCode(
                        repaintKey: repaintKey,
                        linkQrCode:
                            "${DeepLinkConstant.productDetail}/${product.id}",
                        iconBack: IconConstant.arrowLeft,
                        title: product.name,
                        cancelText: TextConstant.cancel,
                        continueText: TextConstant.share,
                        isLoading: productController.isLoading,
                        continueOnTap: () => shareService.shareQrAsImage(
                            title: product.name, repaintKey: repaintKey),
                        sufixOnTap: () => shareService.copyTextLink(
                          "${DeepLinkConstant.productDetail}/${product.id}",
                        ),
                        sufixIcon: IconConstant.contentCopy,
                      ),
                    );
                  },
                  firstIcon: IconConstant.media,
                  firstLabel: TextConstant.shareMidia,
                  firtOnTap: () async => await shareService.shareImageTextLink(
                    product.image,
                    TextConstant.shareTextProduct(
                      product.id,
                      product.name,
                      product.amount,
                      product.price,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: SizeToken.lg,
              ),
              ContentDefault(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextHeadlineH1(text: product.name),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: SizeToken.sm),
                          child: TextHeadlineH1(
                            text: TextConstant.monetaryValue(
                              double.parse(product.price),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SizeToken.md,
                    ),
                    TextBodyB1SemiDark(
                      text: product.description,
                    ),
                    const SizedBox(
                      height: SizeToken.md,
                    ),
                    Observer(builder: (_) {
                      final store = storeController.store;
                      if (storeController.isLoading || store == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (productController.isServerError) {
                        return BannerError(
                          image: ImageErrorConstant.serverError,
                          text: TextConstant.serverError,
                        );
                      }
                      return StoreItem(
                        name: store.name,
                        description: store.description,
                        image: store.image,
                        icon: IconConstant.chevronRigth,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StoreDetailScreenWidget(
                              storeModel: store,
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: ButtonLarge(
        key: const Key("openAlertOrder"),
        text: TextConstant.placeOrder,
        icon: IconConstant.cart,
        onPressed: () => storeController.store != null
            ? showDialog(
                context: context,
                builder: (context) => Observer(builder: (_) {
                  return AlertOrder(
                    product: product,
                    store: storeController.store!,
                  );
                }),
              )
            : null,
      ),
    );
  }
}
