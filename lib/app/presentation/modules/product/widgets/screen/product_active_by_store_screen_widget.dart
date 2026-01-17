// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_fome/app/presentation/controllers/store/store_controller.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/app/utils/constants/icon_constant.dart';
import 'package:my_fome/app/utils/constants/image_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:my_fome/app/presentation/controllers/product/product_controller.dart';
import 'package:my_fome/app/presentation/modules/product/widgets/screen/my_product_detail_screen.dart';
import 'package:go_router/go_router.dart';

class ProductActiveByStoreScreenWidget extends StatefulWidget {
  final String storeId;
  const ProductActiveByStoreScreenWidget({
    super.key,
    required this.storeId,
  });

  @override
  State<ProductActiveByStoreScreenWidget> createState() =>
      _ProductActiveByStoreScreenWidget();
}

class _ProductActiveByStoreScreenWidget
    extends State<ProductActiveByStoreScreenWidget> {
  final productController = Injector.get<ProductController>();
  final storeController = Injector.get<StoreController>();

  @override
  void initState() {
    super.initState();
    productController.listProductsActiveByStore(widget.storeId);
    storeController.detailStore(widget.storeId);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (productController.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (productController.isServerError) {
          return BannerDefault(
            image: ImageConstant.serverError,
            text: TextConstant.serverError,
          );
        }
        if (productController.productFilterListActiveByStore!.isEmpty) {
          return BannerDefault(
              image: ImageConstant.empty, text: TextConstant.productNotFound);
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:
                MediaQuery.of(context).size.width < 375 ? double.infinity : 175,
            mainAxisSpacing: 20,
            crossAxisSpacing: 15,
            mainAxisExtent: 270,
          ),
          itemCount:
              productController.productFilterListActiveByStore?.length ?? 0,
          itemBuilder: (context, index) {
            final product =
                productController.productFilterListActiveByStore?[index];
            return ProductItem(
              key: const Key("selectItemProduct"),
              icon: IconConstant.remove,
              onTapIcon: () => showCustomModalBottomSheet(
                context: context,
                builder: (context) => ModalSheet(
                  iconBack: IconConstant.arrowLeft,
                  title: TextConstant.suspendProductTitle,
                  description: TextConstant.suspendProductMessage(product.name),
                  cancelText: TextConstant.no,
                  continueText: TextConstant.yes,
                  isLoading: productController.isLoading,
                  continueOnTap: () {
                    productController.toggleActive(
                        product.id, storeController.store!.id);
                    context.pop();
                  },
                ),
              ),
              image: product!.image,
              name: product.name,
              quantity: TextConstant.quantityAvailable(product.amount),
              price: TextConstant.monetaryValue(double.parse(product.price)),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        MyProductDetailScreen(product: product)),
              ),
            );
          },
        );
      },
    );
  }
}
