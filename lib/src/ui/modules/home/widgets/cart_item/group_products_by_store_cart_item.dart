// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fome/src/ui/controllers/cartItem/cart_item_controller.dart';
import 'package:my_fome/src/ui/controllers/product/product_controller.dart';
import 'package:my_fome/src/ui/modules/home/widgets/screens/product_detail_screen_widget.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_group_store_dto.dart';
import 'package:my_fome/src/ui/modules/home/controllers/freight/freight_controller.dart';

class GroupProductsByStoreCartItem extends StatefulWidget {
  final String user;
  final double userLatitude;
  final double userLongitude;
  final CartItemGroupStoreDto cartItem;
  final void Function() ontapOrder;
  final void Function() onTapStore;

  const GroupProductsByStoreCartItem({
    super.key,
    required this.userLatitude,
    required this.userLongitude,
    required this.cartItem,
    required this.ontapOrder,
    required this.onTapStore,
    required this.user,
  });

  @override
  State<GroupProductsByStoreCartItem> createState() =>
      _GroupProductsByStoreCartItemState();
}

class _GroupProductsByStoreCartItemState
    extends State<GroupProductsByStoreCartItem> {
  final cartItemController = Injector.get<CartItemController>();

  final productController = Injector.get<ProductController>();

  final freightController = FreightController();

  late double freight = 0;

  @override
  void initState() {
    super.initState();
    if (widget.cartItem.storeIsDelivered) {
      freight = freightController.getFreight(
        widget.userLatitude,
        widget.userLongitude,
        double.parse(widget.cartItem.storeLatitude!),
        double.parse(widget.cartItem.storeLongitude!),
        double.parse(widget.cartItem.storeFreight!),
      );
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
                  text: widget.cartItem.storeIsDelivered
                      ? TextConstant.totalValue(
                          double.parse(widget.cartItem.total) + freight)
                      : TextConstant.totalValue(
                          double.parse(widget.cartItem.total),
                        ),
                ),
              ],
            ),
            widget.cartItem.storeIsDelivered
                ? TextBodyB2SemiDark(text: TextConstant.freigthValue(freight))
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
          child: ButtonSmallDark(
            text: TextConstant.placeOrder,
            onPressed: widget.ontapOrder,
          ),
        )
      ],
    );
  }
}
