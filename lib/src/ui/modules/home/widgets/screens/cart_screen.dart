// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/constants/image_error_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/ui/controllers/address/address_controller.dart';
import 'package:my_fome/src/ui/controllers/auth/auth_google_controller.dart';
import 'package:my_fome/src/ui/controllers/cartItem/cart_item_controller.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/modules/home/widgets/cart_item/group_products_by_store_cart_item.dart';
import 'package:my_fome/src/ui/modules/home/widgets/screens/store_detail_screen_widget.dart';
import 'package:uikit/uikit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartItemController = Injector.get<CartItemController>();
  final addressController = Injector.get<AddressController>();
  final authController = Injector.get<AuthGoogleController>();
  final storeController = Injector.get<StoreController>();

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    if (authController.user?.id != null) {
      await addressController.detailAddressUser(authController.user!.id);
      await cartItemController.getByGroupStoreByUser(authController.user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: SizeToken.md,
          ),
          Observer(builder: (context) {
            if (authController.user == null) {
              return Center(
                child: BannerError(
                  image: ImageErrorConstant.login,
                  text: TextConstant.requiredLogin,
                ),
              );
            }

            if (cartItemController.isLoading || addressController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              spacing: SizeToken.md,
              children: [
                ContentDefault(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: SizeToken.sm,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextHeadlineH2(text: TextConstant.address),
                          addressController.address?.userId != null
                              ? LinkSeeMore(
                                  text: TextConstant.editAddress,
                                  onTap: () {
                                    context.push(
                                      '/address/update/delivery',
                                      extra: addressController.address,
                                    );
                                  },
                                )
                              : LinkSeeMore(
                                  text: TextConstant.createAddress,
                                  onTap: () async {
                                    await authController.load();
                                    if (authController.user?.id != null) {
                                      await addressController.detailAddressUser(
                                          authController.user!.id);
                                      await cartItemController
                                          .getByGroupStoreByUser(
                                              authController.user!.id);
                                    }
                                    if (addressController.isLoading == false) {
                                      context.push('/address/register/delivery',
                                          extra: authController.user!.id);
                                    }
                                  },
                                ),
                        ],
                      ),
                      addressController.address?.userId != null
                          ? TextLabelL4Secondary(
                              text:
                                  "${addressController.address?.number}, ${addressController.address?.street}, ${addressController.address?.district}, ${addressController.address?.city}, ${addressController.address?.state}",
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
                DividerDefault(),
                if (cartItemController.cartItems == null ||
                    cartItemController.cartItems!.isEmpty)
                  BannerError(
                    image: ImageErrorConstant.empty,
                    text: TextConstant.cartItemEmpty,
                  ),
                addressController.address?.userId == null
                    ? BannerError(
                        image: ImageErrorConstant.empty,
                        text: TextConstant.cartItemEmpty,
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: SizeToken.lg),
                          child: DividerDefault(),
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cartItemController.cartItems?.length ?? 0,
                        itemBuilder: (context, index) {
                          final cartItem = cartItemController.cartItems![index];
                          return ContentDefault(
                            child: GroupProductsByStoreCartItem(
                              addressUser: addressController.address!,
                              user: authController.user!.id,
                              cartItem: cartItem,
                              onTapStore: () async {
                                await storeController
                                    .detailStore(cartItem.storeId);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        StoreDetailScreenWidget(
                                      storeModel: storeController.store,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ],
            );
          }),
          const SizedBox(height: SizeToken.lg),
        ],
      ),
    );
  }
}
