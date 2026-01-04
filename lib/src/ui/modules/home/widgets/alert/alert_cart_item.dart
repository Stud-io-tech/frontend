// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
/* import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_fome/src/data/services/payments/payment_service.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';

import 'package:my_fome/src/ui/controllers/auth/auth_google_controller.dart';
import 'package:my_fome/src/ui/modules/home/controllers/counter/cartItem/cart_item_counter_controller.dart';
import 'package:uikit/atomic/molecules/molecule.dart';
import 'package:uikit/tokens/token.dart';

import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';
import 'package:go_router/go_router.dart';

class AlertCartItem extends StatelessWidget {
  final ProductDetailDto product;
  final StoreDetailDto store;

  AlertCartItem({
    Key? key,
    required this.product,
    required this.store,
  }) : super(key: key);

  final cartItemCounterController = CartItemCounterController();
  final authController = Injector.get<AuthGoogleController>();
  final fileService = Injector.get<FileService>();
 
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
        ButtonLarge(
            key: const Key("finalizeOrder"),
            text: TextConstant.placeOrder,
            icon: IconConstant.success,
            onPressed: () async {
            final List<CartItemDto> cartItens = [];

            final cartItem = CartItemDto(
              product: product,
              amount: cartItemCounterController.value,
              storeId: store.id,
            );

            cartItens.add(cartItem);

            final order = OrderDto(
                code: "0069",
                user: authController.user ??
                    UserDetailDto(
                      id: "123",
                      name: "Lázaro Luis",
                      email: "lazaroluis@gmail.com",
                    ),
                store: store,
                typePayment: TypePaymentEnum.PIX,
                cartItens: cartItens,
                total: cartItemCounterController.totalValue,
                city: "Nova Cruz");

            final payment = PaymentPixDto(
                keyPix: 'lazaroalexandre2002@gmail.com',
                name:
                    'Lázaro Luis Martins Alexandre Lázaro Luis Martins Alexandre Lázaro Luis Martins Alexandre',
                city: order.city,
                bring: 10,
                value: cartItemCounterController.totalValue.toString(),
               );

            //final pixCopyPast = await paymentService.generateCopyPast(payment);
            final pixQRCode = await paymentService.generateQRCode(payment);
            final pathPdf = await fileService.generatePDFOrder(order, pixQrCode: pixQRCode,bring: payment.bring);

            // ignore: use_build_context_synchronously
            context.push(
              '/order-pdf',
              extra: {
                'path': pathPdf,
                'whatsapp': "+5584992017118",
                'code': order.code
              },
            );
          },
        ), 
            })
      ],
    );
  }

 */

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
            text: TextConstant.placeOrder,
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
