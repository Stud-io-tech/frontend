// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/app/utils/constants/api_constant.dart';
import 'package:my_fome/app/utils/constants/deep_link_constant.dart';
import 'package:my_fome/app/utils/constants/icon_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:my_fome/app/data/services/share/share_service.dart';

import 'package:my_fome/app/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/app/presentation/controllers/address/address_controller.dart';
import 'package:my_fome/app/presentation/controllers/product/product_controller.dart';
import 'package:my_fome/app/presentation/controllers/store/store_controller.dart';
import 'package:my_fome/app/presentation/modules/home/widgets/screens/product_detail_screen_widget.dart';
import 'package:my_fome/app/presentation/modules/product/pages/product_by_store_page.dart';
import 'package:uikit/uikit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StoreDetailScreenWidget extends StatefulWidget {
  final StoreDetailDto? storeModel;
  final String? id;
  const StoreDetailScreenWidget({
    super.key,
    this.storeModel,
    this.id,
  });

  @override
  State<StoreDetailScreenWidget> createState() =>
      _StoreDetailScreenWidgetState();
}

class _StoreDetailScreenWidgetState extends State<StoreDetailScreenWidget> {
  final storeController = Injector.get<StoreController>();
  final productController = Injector.get<ProductController>();
  final addressController = Injector.get<AddressController>();

  final shareService = Injector.get<ShareService>();
  static final GlobalKey repaintKey = GlobalKey();

  late StoreDetailDto store;

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
      body: Observer(builder: (context) {
        if (widget.id != null && storeController.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (widget.id != null) {
          store = storeController.store!;
        } else {
          store = widget.storeModel!;
        }
        productController.listProductsActiveByStore(store.id);
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageDetail(
                image: store.image,
                iconLeft: IconConstant.arrowLeft,
                onTapIconLeft: () =>
                    widget.id != null ? context.go('/home') : context.pop(),
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
                        continueOnTap: () => shareService.shareQrAsImage(
                            title: store.name, repaintKey: repaintKey),
                        sufixOnTap: () => shareService.copyTextLink(
                          "${DeepLinkConstant.storeDetail}/${store.id}",
                        ),
                        sufixIcon: IconConstant.contentCopy,
                      ),
                    );
                  },
                  firstIcon: IconConstant.media,
                  firstLabel: TextConstant.shareMidia,
                  firtOnTap: () async => await shareService.shareImageTextLink(
                    store.image,
                    TextConstant.shareTextStore(
                      store.id,
                      store.name,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        store.isOpen
                            ? TextLabelL4Success(text: TextConstant.open)
                            : TextLabelL4Info(text: TextConstant.close),
                        TextLabelL4Dark(
                            text: store.isDelivered
                                ? " | ${TextConstant.weDelivery}"
                                : " | ${TextConstant.weNotDelivery}"),
                      ],
                    ),
                    const SizedBox(
                      height: SizeToken.xxs,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextHeadlineH1(text: store.name),
                        ),
                        Observer(
                          builder: (_) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: SizeToken.sm),
                              child: IconButtonLargeDark(
                                  onTap: () => launchUrlString(
                                        'https://wa.me/${addressController.addressStore?.whatsapp}?text=${Uri.encodeComponent("Olá, ${store.name}!\n\nEu gostaria de tirar algumas dúvidas. Você poderia me ajudar?")}',
                                      ),
                                  icon: IconConstant.whatsapp),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SizeToken.md,
                    ),
                    TextLabelL4Secondary(text: store.schedules),
                    const SizedBox(
                      height: SizeToken.md,
                    ),
                    TextBodyB1SemiDark(
                      text: store.description,
                    ),
                    const SizedBox(
                      height: SizeToken.md,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextHeadlineH2(text: TextConstant.storeProducts),
                        LinkSeeMore(
                          text: TextConstant.seeMore,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductByStorePage(store: store),
                            ),
                          ),
                        ),
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
                              image: product!.image,
                              name: product.name,
                              quantity: TextConstant.quantityAvailable(
                                  product.amount),
                              price: TextConstant.monetaryValue(
                                  double.parse(product.price)),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailScreenWidget(
                                          productModel: product),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                    const SizedBox(
                      height: SizeToken.md,
                    ),
                    TextHeadlineH2(text: TextConstant.address),
                    const SizedBox(
                      height: SizeToken.sm,
                    ),
                    AddressDetailsMap(
                      urlTemplate: ApiConstant.tileOpenStreetMap,
                      userAgentPackageName: ApiConstant.userAgent,
                      fullAddress:
                          "${addressController.addressStore?.number}, ${addressController.addressStore?.street}, ${addressController.addressStore?.district}, ${addressController.addressStore?.city}, ${addressController.addressStore?.state}",
                      latitude: addressController.addressStore?.latitude != null
                          ? double.parse(
                              addressController.addressStore!.latitude!)
                          : null,
                      longitude:
                          addressController.addressStore?.longitude != null
                              ? double.parse(
                                  addressController.addressStore!.longitude!)
                              : null,
                    ),
                    const SizedBox(
                      height: SizeToken.lg,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
