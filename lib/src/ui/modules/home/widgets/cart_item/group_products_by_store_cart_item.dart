// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/data/services/files/file_service.dart';
import 'package:my_fome/src/domain/dtos/address/address_detail_dto.dart';
import 'package:my_fome/src/ui/controllers/auth/auth_google_controller.dart';
import 'package:my_fome/src/ui/controllers/cartItem/cart_item_controller.dart';
import 'package:my_fome/src/ui/controllers/product/product_controller.dart';
import 'package:my_fome/src/ui/controllers/order/code/code_order_random_controller.dart';
import 'package:my_fome/src/ui/modules/home/widgets/screens/product_detail_screen_widget.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_group_store_dto.dart';
import 'package:my_fome/src/ui/modules/home/controllers/freight/freight_controller.dart';

class GroupProductsByStoreCartItem extends StatefulWidget {
  final String user;
  final CartItemGroupStoreDto cartItem;
  final AddressDetailDto addressUser;
  final void Function() onTapStore;

  const GroupProductsByStoreCartItem({
    super.key,
    required this.cartItem,
    required this.onTapStore,
    required this.user,
    required this.addressUser,
  });

  @override
  State<GroupProductsByStoreCartItem> createState() =>
      _GroupProductsByStoreCartItemState();
}

class _GroupProductsByStoreCartItemState
    extends State<GroupProductsByStoreCartItem> {
  final fileService = Injector.get<FileService>();

  final cartItemController = Injector.get<CartItemController>();

  final productController = Injector.get<ProductController>();

  final freightController = FreightController();

  final codeOrderRandomController = CodeOrderRandomController();

  final authGoogleController = Injector.get<AuthGoogleController>();

  late List<double> freightAndDistance;

  late double freight = 0.00;

  late int maxEstimateTimeDelivery = 0;
  late int minEstimateTimeDelivery = 0;

  @override
  void initState() {
    super.initState();
    if (widget.cartItem.storeIsDelivered) {
      freightAndDistance = freightController.getFreight(
        double.parse(widget.addressUser.latitude.toString()),
        double.parse(widget.addressUser.longitude.toString()),
        double.parse(widget.cartItem.storeLatitude.toString()),
        double.parse(widget.cartItem.storeLongitude.toString()),
        double.parse(widget.cartItem.storeFreight.toString()),
      );

      maxEstimateTimeDelivery = (freightAndDistance.first.round() *
              widget.cartItem.storeDeliveryTimeKm) +
          widget.cartItem.maxPreparationTime;

      minEstimateTimeDelivery = (freightAndDistance.first.round() *
              widget.cartItem.storeDeliveryTimeKm) +
          widget.cartItem.minPreparationTime;

      freight = freightAndDistance.last;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: SizeToken.lg,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: SizeToken.sm,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      SizeToken.xxs,
                    ),
                    onTap: widget.onTapStore,
                    child: Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: SizeToken.sm,
                        children: [
                          Flexible(
                              child: TextLabelL2Dark(
                            text: widget.cartItem.storeName,
                            maxLines: 1,
                            overflow: true,
                          )),
                          IconLargeDark(
                            icon: IconConstant.keyboardArrowRight,
                            padding: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                TextLabelL2Dark(
                  text: (widget.cartItem.storeIsDelivered ||
                          (widget.cartItem.storeLatitude != null &&
                              widget.cartItem.storeLongitude != null))
                      ? TextConstant.totalValue(
                          double.parse(widget.cartItem.total) + freight)
                      : TextConstant.totalValue(
                          double.parse(widget.cartItem.total),
                        ),
                ),
              ],
            ),
            widget.cartItem.storeIsDelivered
                ? TextBodyB2SemiDark(
                    text:
                        "${TextConstant.freigthValue(freight)} | ⏱︎ $minEstimateTimeDelivery - ${maxEstimateTimeDelivery == minEstimateTimeDelivery ? maxEstimateTimeDelivery + 5 : maxEstimateTimeDelivery} min")
                : TextBodyB2Danger(text: TextConstant.storeDontDelivery)
          ],
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.cartItem.cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = widget.cartItem.cartItems[index];

            return CartItemItem(
                name: cartItem.name.toString(),
                price:
                    TextConstant.monetaryValue(double.parse(cartItem.price!)),
                image: cartItem.image.toString(),
                iconRemove: IconConstant.remove,
                iconIncrement: IconConstant.keyboardArrowUp,
                iconDecrement: IconConstant.keyboardArrowDown,
                amount: cartItem.amount,
                onTapItem: () async {
                  await productController.detailProduct(cartItem.productId);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreenWidget(
                          productModel: productController.product),
                    ),
                  );
                },
                onTapRemove: () async {
                  showCustomModalBottomSheet(
                    context: context,
                    builder: (context) => ModalSheet(
                      isLoading: cartItemController.isLoading,
                      iconBack: IconConstant.arrowLeft,
                      title: TextConstant.logoutAccountTitle,
                      description: TextConstant.removeCartItemMessage(
                        cartItem.name.toString(),
                      ),
                      cancelText: TextConstant.no,
                      continueText: TextConstant.yes,
                      continueOnTap: () async {
                        await cartItemController.delete(
                            cartItem.id, widget.user);
                        context.pop();
                      },
                    ),
                  );
                },
                onTapIcrement: () async {
                  await productController.detailProduct(cartItem.productId);

                  if ((cartItem.amount + 1) <=
                      productController.product!.amount) {
                    await cartItemController.updateAmount(
                        (cartItem.amount + 1), cartItem.id, widget.user);
                  }
                },
                onTapDecrement: () async {
                  if ((cartItem.amount - 1) > 0) {
                    await cartItemController.updateAmount(
                        (cartItem.amount - 1), cartItem.id, widget.user);
                  }
                });
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: SizeToken.xxs),
            child: DividerDefault(),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Observer(builder: (context) {
            return widget.cartItem.storeIsOpen
                ? ButtonSmallDark(
                    text: TextConstant.placeOrder,
                    onPressed: () {
                      CartItemGroupStoreDto newCartItem = CartItemGroupStoreDto(
                        storeIsOpen: widget.cartItem.storeIsOpen,
                        storePix: widget.cartItem.storePix,
                        storeWhatsapp: widget.cartItem.storeWhatsapp,
                        storeDeliveryTimeKm:
                            widget.cartItem.storeDeliveryTimeKm,
                        storeId: widget.cartItem.storeId,
                        storeName: widget.cartItem.storeName,
                        total: (widget.cartItem.storeIsDelivered ||
                                (widget.cartItem.storeLatitude != null &&
                                    widget.cartItem.storeLongitude != null))
                            ? (double.parse(widget.cartItem.total) + freight)
                                .toString()
                            : widget.cartItem.total.toString(),
                        minPreparationTime: minEstimateTimeDelivery,
                        maxPreparationTime: maxEstimateTimeDelivery == minEstimateTimeDelivery ? maxEstimateTimeDelivery + 5 : maxEstimateTimeDelivery,
                        storeFreight: freight.toString(),
                        storeIsDelivered: widget.cartItem.storeIsDelivered,
                        cartItems: widget.cartItem.cartItems,
                      );

                      context.push(
                        '/order-pdf',
                        extra: {
                          'cart': newCartItem,
                          'address': widget.addressUser,
                          'userName':
                              authGoogleController.user?.name.toString(),
                        },
                      );
                    },
                  )
                : ButtonSmallSemiDark(text: TextConstant.storeIsNotOpen);
          }),
        )
      ],
    );
  }
}
