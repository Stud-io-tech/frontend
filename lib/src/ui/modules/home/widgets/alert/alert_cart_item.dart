import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_fome/src/data/services/payments/payment_service.dart';
import 'package:my_fome/src/domain/dtos/cartItem/cart_item_register_dto.dart';

import 'package:my_fome/src/ui/controllers/auth/auth_google_controller.dart';
import 'package:my_fome/src/ui/controllers/cartItem/cart_item_controller.dart';
import 'package:my_fome/src/ui/modules/home/controllers/counter/cartItem/cart_item_counter_controller.dart';
import 'package:uikit/atomic/molecules/molecule.dart';
import 'package:uikit/tokens/token.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';
import 'package:go_router/go_router.dart';

class AlertCartItem extends StatelessWidget {
  final ProductDetailDto product;
  final String userId;
  AlertCartItem({
    super.key,
    required this.product,
    required this.userId,
  });

  final cartItemCounterController = CartItemCounterController();
  final authController = Injector.get<AuthGoogleController>();
  final cartItemController = Injector.get<CartItemController>();

  final paymentService = Injector.get<PaymentService>();

  @override
  Widget build(BuildContext context) {
    cartItemCounterController.setPrice(double.parse(product.price));
    return AlertDialog(
      title: SizedBox(
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextHeadlineH2(
              text: TextConstant.addQuantity,
            ),
            IconButtonMediumDark(
              isBackgroundColor: false,
              onTap: () => context.pop(),
              icon: IconConstant.close,
            ),
          ],
        ),
      ),
      content: SizedBox(
        height: 142,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: SizeToken.lg,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconLargeDark(
                  isBackgroundColor: true,
                  onTap: () => cartItemCounterController.decrement(),
                  icon: IconConstant.minius,
                ),
                const SizedBox(
                  width: SizeToken.sm,
                ),
                Observer(builder: (_) {
                  return TextBodyB1Dark(
                    text: cartItemCounterController.value.toString(),
                  );
                }),
                const SizedBox(
                  width: SizeToken.sm,
                ),
                IconLargeDark(
                  key: const Key("incrementProductOnOrder"),
                  isBackgroundColor: true,
                  onTap: () {
                    cartItemCounterController.increment(product.amount);
                  },
                  icon: IconConstant.add,
                ),
              ],
            ),
            const SizedBox(
              height: SizeToken.xxl,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHeadlineH1(
                  text: TextConstant.total,
                ),
                Observer(builder: (_) {
                  return TextHeadlineH1(
                    text: TextConstant.monetaryValue(
                      cartItemCounterController.totalValue,
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.zero,
      actions: [
        Observer(builder: (_) {
          return ButtonLarge(
            key: const Key("finalizeOrder"),
            text: TextConstant.addCart,
            icon: IconConstant.success,
            isLoading: cartItemController.isLoading,
            onPressed: () async {
              CartItemRegisterDto model = CartItemRegisterDto(
                productId: product.id,
                userId: userId,
                amount: cartItemCounterController.value,
              );

              try {
                await authController.load();
                await cartItemController.register(model);
              } finally {
                if (cartItemController.isLoading == false) {
                  cartItemCounterController.cleanValue();
                  context.pop();
                }
              }
            },
          );
        }),
      ],
    );
  }
}
