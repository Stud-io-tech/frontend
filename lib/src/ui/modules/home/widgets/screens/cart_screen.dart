import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/constants/image_error_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/ui/controllers/address/address_controller.dart';
import 'package:my_fome/src/ui/controllers/auth/auth_google_controller.dart';
import 'package:my_fome/src/ui/modules/home/widgets/cart_item/group_products_by_store_cart_item.dart';
import 'package:uikit/uikit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final addressController = Injector.get<AddressController>();
  final authController = Injector.get<AuthGoogleController>();

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    if (authController.user?.id != null) {
      await addressController.detailAddressUser(authController.user!.id);
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

            if (addressController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              spacing: SizeToken.md,
              children: [
                ContentDefault(
                  child: Column(
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
                                  onTap: () {
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
                ListView.separated(
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: SizeToken.lg),
                    child: DividerDefault(),
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) => ContentDefault(
                    child: GroupProductsByStoreCartItem(
                      dynamicFreightKm: 0.5,
                      storeLatitude: -6.526858391660521,
                      storeLongitude: -35.612261806913914,
                      userLatitude: -6.476603791117846,
                      userLongitude: -35.428223619859764,
                      storeName: "Pastelaria Favorita",
                      total: 10,
                      onTapStore: () {},
                      ontapOrder: () {},
                    ),
                  ),
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
