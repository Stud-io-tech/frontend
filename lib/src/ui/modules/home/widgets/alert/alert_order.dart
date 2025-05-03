// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:uikit/atomic/molecules/molecule.dart';
import 'package:uikit/tokens/token.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';
import 'package:my_fome/src/ui/modules/home/controllers/order/order_controller.dart';
import 'package:go_router/go_router.dart';

class AlertOrder extends StatelessWidget {
  final ProductDetailDto product;
  final String? whatsapp;
  final String? store;

  AlertOrder({
    super.key,
    required this.product,
    this.whatsapp,
    this.store,
  });

  final orderController = OrderController();

  @override
  Widget build(BuildContext context) {
    orderController.setPrice(double.parse(product.price));
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
                  onTap: () => orderController.decrement(),
                  icon: IconConstant.minius,
                ),
                const SizedBox(
                  width: SizeToken.sm,
                ),
                Observer(builder: (_) {
                  return TextBodyB1Dark(
                    text: orderController.value.toString(),
                  );
                }),
                const SizedBox(
                  width: SizeToken.sm,
                ),
                IconLargeDark(
                  key: const Key("incrementProductOnOrder"),
                  isBackgroundColor: true,
                  onTap: () {
                    orderController.increment(product.amount);
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
                      orderController.totalValue,
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
        ButtonLarge(
          key: const Key("finalizeOrder"),
          text: TextConstant.placeOrder,
          icon: IconConstant.success,
          onPressed: () => launchUrlString(
              'https://wa.me/$whatsapp?text=Olá, $store!%0A%0AEu gostaria de comprar *${orderController.value} ${product.name}*.%0A%0A*Valor Total:* ${TextConstant.monetaryValue(orderController.totalValue)}'),
        ),
      ],
    );
  }
}
