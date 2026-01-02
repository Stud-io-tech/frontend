// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/ui/modules/home/controllers/counter/cartItem/cart_item_counter_controller.dart';
import 'package:my_fome/src/ui/modules/home/controllers/freight/freight_controller.dart';

class GroupProductsByStoreCartItem extends StatefulWidget {
  final String storeName;
  final double total;
  final double dynamicFreightKm;
  final double userLatitude;
  final double userLongitude;
  final double storeLatitude;
  final double storeLongitude;
  final void Function() ontapOrder;
  final void Function() onTapStore;

  const GroupProductsByStoreCartItem({
    super.key,
    required this.storeName,
    required this.total,
    required this.dynamicFreightKm,
    required this.userLatitude,
    required this.userLongitude,
    required this.storeLatitude,
    required this.storeLongitude,
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
    freight = freightController.getFreight(
        widget.userLatitude,
        widget.userLongitude,
        widget.storeLatitude,
        widget.storeLongitude,
        widget.dynamicFreightKm);
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
                            text: widget.storeName,
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
                  text: TextConstant.totalValue(widget.total+freight),
                ),
              ],
            ),
            TextBodyB2SemiDark(text: TextConstant.freigthValue(freight))
          ],
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            final int amount = index + 2;

            return CartItemItem(
                name: "Pastel de Frango 200g",
                price: TextConstant.monetaryValue(5.00),
                image: "https://avatars.githubusercontent.com/u/103341140?v=4",
                iconRemove: IconConstant.remove,
                iconIncrement: IconConstant.keyboardArrowUp,
                iconDecrement: IconConstant.keyboardArrowDown,
                amount: amount,
                onTapItem: () {},
                onTapRemove: () {},
                onTapIcrement: () {
                  cartItemCounterController.incrementCart(amount, amount + 1);
                },
                onTapDecrement: () {
                  cartItemCounterController.decrementCart(amount);
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
