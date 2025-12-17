// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_fome/src/constants/deep_link_constant.dart';
import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/data/services/share/share_service.dart';

import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';
import 'package:my_fome/src/ui/controllers/product/product_controller.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/controllers/switch/switch_controller.dart';
import 'package:my_fome/src/ui/modules/home/widgets/screens/store_detail_screen_widget.dart';
import 'package:uikit/uikit.dart';
import 'package:go_router/go_router.dart';

class MyProductDetailScreen extends StatefulWidget {
  final ProductDetailDto product;
  const MyProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<MyProductDetailScreen> createState() => _MyProductDetailScreenState();
}

class _MyProductDetailScreenState extends State<MyProductDetailScreen> {
  final storeController = Injector.get<StoreController>();
  final shareService = Injector.get<ShareService>();
  final productController = Injector.get<ProductController>();
  static final GlobalKey repaintKey = GlobalKey();
  final swicthController = Injector.get<SwitchController>();
  final bool isOpen = true;

  @override
  void initState() {
    super.initState();
    storeController.detailStore(widget.product.storeId);
    swicthController.setValue(isOpen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageDetail(
              image: widget.product.image,
              iconLeft: IconConstant.arrowLeft,
              onTapIconLeft: () => context.pop(),
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
                          "${DeepLinkConstant.productDetail}/${widget.product.id}",
                      iconBack: IconConstant.arrowLeft,
                      title: widget.product.name,
                      cancelText: TextConstant.cancel,
                      continueText: TextConstant.share,
                      isLoading: productController.isLoading,
                      continueOnTap: () => shareService.shareQrAsImage(
                          title: widget.product.name, repaintKey: repaintKey),
                      sufixOnTap: () => shareService.copyTextLink(
                        "${DeepLinkConstant.productDetail}/${widget.product.id}",
                      ),
                      sufixIcon: IconConstant.contentCopy,
                    ),
                  );
                },
                firstIcon: IconConstant.media,
                firstLabel: TextConstant.shareMidia,
                firtOnTap: () async => await shareService.shareImageTextLink(
                  widget.product.image,
                  TextConstant.shareTextProduct(
                    widget.product.id,
                    widget.product.name,
                    widget.product.amount,
                    widget.product.price,
                  ),
                ),
              ),
              iconDown: IconConstant.edit,
              onTapIconDown: () =>
                  context.push('/product/update', extra: widget.product),
            ),
            const SizedBox(
              height: SizeToken.lg,
            ),
            ContentDefault(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      swicthController.value
                          ? TextLabelL4Success(text: TextConstant.open)
                          : TextLabelL4Info(text: TextConstant.close),
                      TextLabelL4Dark(
                        text:
                            " | ${TextConstant.quantityAvailableUpperCase(widget.product.amount)}",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: SizeToken.sm,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextHeadlineH1(text: widget.product.name),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: SizeToken.sm),
                        child: TextHeadlineH1(
                          text: TextConstant.monetaryValue(
                            double.parse(widget.product.price),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: SizeToken.md,
                  ),
                  Row(
                    spacing: SizeToken.xs,
                    children: [
                      IconMediumSemiDark(
                        icon: IconConstant.timer,
                        padding: SizeToken.xs,
                        isBackgroundColor: true,
                        onTap: () {},
                      ),
                      Flexible(
                        child: TextLabelL4Secondary(
                          text: TextConstant.preparationTime(10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: SizeToken.md,
                  ),
                  TextBodyB1SemiDark(
                    text: widget.product.description,
                  ),
                  const SizedBox(
                    height: SizeToken.md,
                  ),
                  TextHeadlineH2(text: TextConstant.store),
                  const SizedBox(
                    height: SizeToken.sm,
                  ),
                  Observer(builder: (_) {
                    final store = storeController.store;
                    if (storeController.isLoading || store == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
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
                  }),
                  const SizedBox(
                    height: SizeToken.lg,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
