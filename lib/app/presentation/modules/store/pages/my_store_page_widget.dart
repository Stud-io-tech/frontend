// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/app/utils/constants/api_constant.dart';
import 'package:my_fome/app/utils/constants/deep_link_constant.dart';
import 'package:my_fome/app/data/services/share/share_service.dart';
import 'package:my_fome/app/presentation/controllers/address/address_controller.dart';
import 'package:my_fome/app/presentation/controllers/switch/switch_controller.dart';
import 'package:uikit/uikit.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:my_fome/app/utils/constants/icon_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:my_fome/app/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/app/presentation/controllers/product/product_controller.dart';
import 'package:my_fome/app/presentation/controllers/store/store_controller.dart';

class MyStorePage extends StatefulWidget {
  final String? id;
  const MyStorePage({super.key, this.id});

  @override
  State<MyStorePage> createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  final productController = Injector.get<ProductController>();
  final shareService = Injector.get<ShareService>();
  final storeController = Injector.get<StoreController>();
  static final GlobalKey repaintKey = GlobalKey();

  final swicthController = Injector.get<SwitchController>();

  final addressController = Injector.get<AddressController>();

  @override
  void initState() {
    super.initState();
    load();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (addressController.addressStore == null) {
        context.push('/address/register/store', extra: widget.id);
      }
    });
  }

  void load() async {
    if (widget.id != null) {
      await storeController.detailStore(widget.id!);
      await addressController.detailAddressStore(widget.id!);
      swicthController.setValue(storeController.store!.isOpen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (storeController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          StoreDetailDto store = storeController.store!;
          productController.listProductsActiveByStore(store.id);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Observer(
                    builder: (_) {
                      return ImageDetail(
                        image: store.image,
                        iconLeft: IconConstant.arrowLeft,
                        onTapIconLeft: () => context.go('/home'),
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
                                    "${DeepLinkConstant.storeDetail}/${store.id}",
                                iconBack: IconConstant.arrowLeft,
                                title: store.name,
                                cancelText: TextConstant.cancel,
                                continueText: TextConstant.share,
                                isLoading: productController.isLoading,
                                continueOnTap: () =>
                                    shareService.shareQrAsImage(
                                  title: store.name,
                                  repaintKey: repaintKey,
                                ),
                                sufixOnTap: () => shareService.copyTextLink(
                                  "${DeepLinkConstant.storeDetail}/${store.id}",
                                ),
                                sufixIcon: IconConstant.contentCopy,
                              ),
                            );
                          },
                          firstIcon: IconConstant.media,
                          firstLabel: TextConstant.shareMidia,
                          firtOnTap: () async =>
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
                    },
                  ),
                  const SizedBox(height: SizeToken.lg),
                  ContentDefault(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Observer(
                          builder: (_) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextHeadlineH1(text: store.name),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: SizeToken.sm,
                                  ),
                                  child: Observer(
                                    builder: (_) {
                                      return IconButtonLargeDark(
                                        onTap: () => launchUrlString(
                                          'https://wa.me/${addressController.addressStore?.whatsapp}?text=${Uri.encodeComponent("Olá, ${store.name}!\n\nEu gostaria de tirar algumas dúvidas. Você poderia me ajudar?")}',
                                        ),
                                        icon: IconConstant.whatsapp,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: SizeToken.md),
                        TextLabelL4Secondary(text: store.schedules),
                        const SizedBox(height: SizeToken.xs),
                        Observer(
                          builder: (_) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    store.isOpen
                                        ? TextLabelL4Success(
                                            text: TextConstant.open,
                                          )
                                        : TextLabelL4Info(
                                            text: TextConstant.close,
                                          ),
                                    TextLabelL4Dark(
                                      text: store.isDelivered
                                          ? " | ${TextConstant.weDelivery}"
                                          : " | ${TextConstant.weNotDelivery}",
                                    ),
                                  ],
                                ),
                                SwicthDefault(
                                  value: swicthController.value,
                                  onChanged: (value) async {
                                    await storeController.changeStatusOpen(
                                      store.id,
                                    );
                                    swicthController.setValue(value);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: SizeToken.xs),
                        Observer(
                          builder: (_) {
                            return TextBodyB1SemiDark(text: store.description);
                          },
                        ),
                        const SizedBox(height: SizeToken.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextHeadlineH2(text: TextConstant.storeProducts),
                            LinkSeeMore(
                              key: const Key("goToMyProducts"),
                              text: TextConstant.seeMore,
                              onTap: () =>
                                  (context).push('/product/my', extra: store),
                            ),
                          ],
                        ),
                        const SizedBox(height: SizeToken.sm),
                        Observer(
                          builder: (context) {
                            if (productController.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (productController
                                    .productFilterListActiveByStore ==
                                []) {
                              return TextLabelL2Dark(
                                text: TextConstant.productNotFound,
                              );
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
                                            .productFilterListActiveByStore!
                                            .length)
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
                                          product.name,
                                        ),
                                        cancelText: TextConstant.no,
                                        continueText: TextConstant.yes,
                                        isLoading: productController.isLoading,
                                        continueOnTap: () {
                                          productController.toggleActive(
                                            product.id,
                                            storeController.store!.id,
                                          );
                                          context.pop();
                                        },
                                      ),
                                    ),
                                    image: product!.image,
                                    name: product.name,
                                    quantity: TextConstant.quantityAvailable(
                                      product.amount,
                                    ),
                                    price: TextConstant.monetaryValue(
                                      double.parse(product.price),
                                    ),
                                    onTap: () => context.go(
                                        '/my-product-detail',
                                        extra: product),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: SizeToken.md,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextHeadlineH2(text: TextConstant.address),
                            LinkSeeMore(
                              text: TextConstant.editAddress,
                              onTap: () {
                                context.push(
                                  '/address/update/store',
                                  extra: addressController.addressStore,
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: SizeToken.sm),
                        if (addressController.addressStore != null)
                          AddressDetailsMap(
                            urlTemplate: ApiConstant.tileOpenStreetMap,
                            userAgentPackageName: ApiConstant.userAgent,
                            fullAddress:
                                "${addressController.addressStore?.number}, ${addressController.addressStore?.street}, ${addressController.addressStore?.district}, ${addressController.addressStore?.city}, ${addressController.addressStore?.state}",
                            latitude: addressController
                                        .addressStore?.latitude !=
                                    null
                                ? double.parse(
                                    addressController.addressStore!.latitude!)
                                : null,
                            longitude: addressController
                                        .addressStore?.longitude !=
                                    null
                                ? double.parse(
                                    addressController.addressStore!.longitude!)
                                : null,
                          ),
                        const SizedBox(height: SizeToken.lg),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
