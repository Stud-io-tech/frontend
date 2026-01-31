// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';

import 'package:my_fome/app/utils/constants/icon_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:my_fome/app/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/app/presentation/controllers/product/product_controller.dart';
import 'package:my_fome/app/presentation/modules/product/controller/button_navigator/button_navigator_menu_controller.dart';
import 'package:my_fome/app/presentation/modules/product/widgets/screen/product_active_by_store_screen_widget.dart';
import 'package:my_fome/app/presentation/modules/product/widgets/screen/product_inactive_by_store_screen_widget.dart';

class ProductByMyStorePage extends StatelessWidget {
  final StoreDetailDto store;

  ProductByMyStorePage({
    super.key,
    required this.store,
  });

  final productController = Injector.get<ProductController>();

  final controller = ButtonNavigatorMenuController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentDefault(
        child: Observer(builder: (_) {
          return Column(
            children: [
              const SizedBox(
                height: SizeToken.xl3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButtonLargeDark(
                          onTap: () => context.push('/store/my/${store.id}'),
                          icon: IconConstant.arrowLeft),
                      const SizedBox(
                        width: SizeToken.sm,
                      ),
                      TextHeadlineH2(text: store.name)
                    ],
                  ),
                  IconButtonLargeDark(
                    key: const Key("goToProductRegister"),
                    isBackgroundColor: false,
                    onTap: () =>
                        context.push('/product/register', extra: store),
                    icon: IconConstant.add,
                  )
                ],
              ),
              const SizedBox(
                height: SizeToken.lg,
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
                    text: controller.currentIndex == 0
                        ? TextConstant.found(
                            productController.activeFoundsByStore)
                        : TextConstant.found(
                            productController.inactiveFoundsByStore),
                  ),
                );
              }),
              const SizedBox(
                height: SizeToken.md,
              ),
              Observer(builder: (context) {
                if (controller.currentIndex == 0) {
                  return Row(
                    children: [
                      Expanded(
                        child: ButtonSmallDark(
                          key: const Key("buttonActivedProducts"),
                          text: TextConstant.actives,
                          onPressed: () => controller.onItemTapped(0),
                        ),
                      ),
                      const SizedBox(
                        width: SizeToken.sm,
                      ),
                      Expanded(
                        child: ButtonSmallLight(
                          key: const Key("buttonSuspendedProducts"),
                          text: TextConstant.suspended,
                          onPressed: () => controller.onItemTapped(1),
                        ),
                      )
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(
                      child: ButtonSmallLight(
                        text: TextConstant.actives,
                        onPressed: () => controller.onItemTapped(0),
                      ),
                    ),
                    const SizedBox(
                      width: SizeToken.sm,
                    ),
                    Expanded(
                      child: ButtonSmallDark(
                        text: TextConstant.suspended,
                        onPressed: () => controller.onItemTapped(1),
                      ),
                    )
                  ],
                );
              }),
              const SizedBox(
                height: SizeToken.md,
              ),
              Expanded(
                child: IndexedStack(
                  index: controller.currentIndex,
                  children: [
                    ProductActiveByStoreScreenWidget(
                      storeId: store.id,
                    ),
                    ProductInactiveByStoreScreenWidget(storeId: store.id),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
