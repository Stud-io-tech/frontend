// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/constants/deep_link_constant.dart';
import 'package:my_fome/src/data/services/share/share_service.dart';
import 'package:uikit/uikit.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/ui/controllers/product/product_controller.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/modules/product/widgets/screen/my_product_detail_screen.dart';

class MyStorePage extends StatefulWidget {
  final String? id;
  const MyStorePage({
    super.key,
    this.id,
  });

  @override
  State<MyStorePage> createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  final productController = Injector.get<ProductController>();
  final shareService = Injector.get<ShareService>();
  final storeController = Injector.get<StoreController>();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      storeController.detailStore(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
        if (storeController.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        StoreDetailDto store = storeController.store!;
        productController.listProductsActiveByStore(store.id);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Observer(builder: (_) {
                  return ImageDetail(
                    image: store.image,
                    iconLeft: IconConstant.arrowLeft,
                    onTapIconLeft: () => context.push('/'),
                    widgetRigth: PopUpMenuShare(
                      menuIcon: IconConstant.share,
                      firstIcon: IconConstant.contentCopy,
                      firstLabel: TextConstant.copyLink,
                      firtOnTap: () => shareService.copyTextLink(
                        "${DeepLinkConstant.storeDetail}/${store.id}",
                      ),
                      secoundIcon: IconConstant.arrowOutward,
                      secoundLabel: TextConstant.share,
                      secoundOnTap: () async =>
                          await shareService.shareImageTextLink(
                        store.image,
                        TextConstant.shareTextStore(
                          store.id,
                          store.name,
                        ),
                      ),
                    ),
                    iconDown: IconConstant.edit,
                    onTapIconDown: () =>
                        context.push('/store/update', extra: store),
                  );
                }),
                const SizedBox(
                  height: SizeToken.lg,
                ),
                ContentDefault(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Observer(builder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextHeadlineH1(text: store.name),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: SizeToken.sm),
                                child: IconButtonLargeDark(
                                    onTap: () => launchUrlString(
                                        'https://wa.me/${store.whatsapp}?text=Olá, ${store.name}!%0A%0AEu gostaria de tirar algumas dúvidas. Você poderia me ajudar?'),
                                    icon: IconConstant.whatsapp)),
                          ],
                        );
                      }),
                      const SizedBox(
                        height: SizeToken.md,
                      ),
                      Observer(builder: (_) {
                        return TextBodyB1SemiDark(
                          text: store.description,
                        );
                      }),
                      const SizedBox(
                        height: SizeToken.md,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextHeadlineH2(text: TextConstant.storeProducts),
                          LinkSeeMore(
                            key: const Key("goToMyProducts"),
                            text: TextConstant.seeMore,
                            onTap: () =>
                                (context).push('/product/my', extra: store),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: SizeToken.sm,
                      ),
                      Observer(builder: (context) {
                        final products =
                            productController.productFilterListActiveByStore;
                        if (productController.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (products == null) {
                          return TextLabelL2Dark(
                              text: TextConstant.productNotFound);
                        }
                        return SizedBox(
                          height: 270,
                          child: GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              mainAxisExtent: 175,
                            ),
                            itemCount: productController
                                        .productFilterListActiveByStore !=
                                    null
                                ? (productController
                                            .productFilterListActiveByStore!
                                            .length >
                                        5
                                    ? 5
                                    : productController
                                        .productFilterListActiveByStore!.length)
                                : 0,
                            itemBuilder: (context, index) {
                              final product = productController
                                  .productFilterListActiveByStore?[index];
                              return ProductItem(
                                icon: IconConstant.remove,
                                onTapIcon: () => showCustomModalBottomSheet(
                                  context: context,
                                  builder: (context) => ModalSheet(
                                    iconBack: IconConstant.arrowLeft,
                                    title: TextConstant.suspendProductTitle,
                                    description:
                                        TextConstant.suspendProductMessage(
                                            product.name),
                                    cancelText: TextConstant.no,
                                    continueText: TextConstant.yes,
                                    isLoading: productController.isLoading,
                                    continueOnTap: () {
                                      productController.toggleActive(product.id,
                                          storeController.store!.id);
                                      context.pop();
                                    },
                                  ),
                                ),
                                image: product!.image,
                                name: product.name,
                                quantity: TextConstant.quantityAvailable(
                                    product.amount),
                                price: TextConstant.monetaryValue(
                                    double.parse(product.price)),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MyProductDetailScreen(product: product),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
