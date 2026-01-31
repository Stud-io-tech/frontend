import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_fome/app/utils/constants/icon_constant.dart';
import 'package:my_fome/app/utils/constants/image_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:my_fome/app/presentation/controllers/product/product_controller.dart';
import 'package:my_fome/app/presentation/modules/home/widgets/screens/product_detail_screen_widget.dart';
import 'package:uikit/uikit.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final productController = Injector.get<ProductController>();

  Future<void> init() async {
    await productController.listProductsActive();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => init(),
      child: LayoutBuilder(
        builder: (context, constraints) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: SizeToken.md,
                ),
                InputSearch(
                  onChanged: productController.filterProducts,
                  hintText: TextConstant.search,
                  prefixIcon: IconConstant.search,
                  sufixOnTap: () {},
                ),
                const SizedBox(
                  height: SizeToken.xxs,
                ),
                Observer(builder: (_) {
                  return Container(
                    padding: const EdgeInsets.only(right: SizeToken.xs),
                    alignment: Alignment.centerRight,
                    child: TextBodyB2SemiDark(
                      text: TextConstant.found(productController.activeFounds),
                    ),
                  );
                }),
                const SizedBox(
                  height: SizeToken.md,
                ),
                Observer(builder: (context) {
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
                  if (productController.productFilterListActive!.isEmpty) {
                    return BannerDefault(
                        image: ImageConstant.empty,
                        text: TextConstant.productNotFound);
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          MediaQuery.of(context).size.width < 375
                              ? double.infinity
                              : 175,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 15,
                      mainAxisExtent: 270,
                    ),
                    itemCount:
                        productController.productFilterListActive?.length ?? 0,
                    itemBuilder: (context, index) {
                      final product =
                          productController.productFilterListActive?[index];
                      return ProductItem(
                        image: product!.image,
                        name: product.name,
                        quantity:
                            TextConstant.quantityAvailable(product.amount),
                        price: TextConstant.monetaryValue(
                            double.parse(product.price)),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreenWidget(
                                productModel: product),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
