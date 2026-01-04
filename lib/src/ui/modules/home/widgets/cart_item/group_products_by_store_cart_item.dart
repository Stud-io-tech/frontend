// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_group_store_dto.dart';
import 'package:my_fome/src/ui/modules/home/controllers/counter/cartItem/cart_item_counter_controller.dart';
import 'package:my_fome/src/ui/modules/home/controllers/freight/freight_controller.dart';

class GroupProductsByStoreCartItem extends StatefulWidget {
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
  });

  @override
  State<GroupProductsByStoreCartItem> createState() =>
      _GroupProductsByStoreCartItemState();
}

class _GroupProductsByStoreCartItemState
    extends State<GroupProductsByStoreCartItem> {
  final cartItemCounterController = CartItemCounterController();

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
            widget.cartItem.storeIsDelivered ? TextBodyB2SemiDark(
                text:  TextConstant.freigthValue(freight))
                    : TextBodyB2Danger(text: TextConstant.storeDontDelivery)
          ],
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.cartItem.cartItems.length,
          itemBuilder: (context, index) {
            final product = widget.cartItem.cartItems[index];

            return CartItemItem(
                name: product.name.toString(),
                price: TextConstant.monetaryValue(double.parse(product.price!)),
                image: product.image.toString(),
                iconRemove: IconConstant.remove,
                iconIncrement: IconConstant.keyboardArrowUp,
                iconDecrement: IconConstant.keyboardArrowDown,
                amount: product.amount,
                onTapItem: () {},
                onTapRemove: () {},
                onTapIcrement: () {
/*                   cartItemCounterController.incrementCart(product.amount, amount + 1);
 */
                },
                onTapDecrement: () {
/*                   cartItemCounterController.decrementCart(amount);
 */
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
