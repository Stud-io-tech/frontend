// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_fome/app/utils/constants/icon_constant.dart';
import 'package:my_fome/app/utils/constants/image_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:my_fome/app/domain/enum/login_redirect_enum.dart';
import 'package:my_fome/app/presentation/controllers/address/address_controller.dart';
import 'package:my_fome/app/presentation/controllers/auth/auth_google_controller.dart';
import 'package:my_fome/app/presentation/controllers/cartItem/cart_item_controller.dart';
import 'package:my_fome/app/presentation/modules/home/controllers/button_navigator/button_navigator_menu_controller.dart';
import 'package:my_fome/app/presentation/modules/home/widgets/screens/cart_screen.dart';
import 'package:my_fome/app/presentation/modules/home/widgets/screens/home_screen_widget.dart';
import 'package:my_fome/app/presentation/modules/home/widgets/screens/product_screen.dart';
import 'package:my_fome/app/presentation/modules/home/widgets/screens/store_screen.dart';
import 'package:uikit/uikit.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = ButtonNavigatorMenuController();

  final authController = Injector.get<AuthGoogleController>();

  final addressController = Injector.get<AddressController>();

  final cartItemController = Injector.get<CartItemController>();

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                SizeToken.md - 3.5, SizeToken.sm, SizeToken.md, 0),
            child: AppBar(
              title: SvgPicture.asset(ImageConstant.horizontalLogo,
                  height: SizeToken.xxl),
              leading: Padding(
                padding: const EdgeInsets.all(3.5),
                child: IconButtonLargeDark(
                    key: const Key('drawerButton'),
                    icon: IconConstant.menu,
                    onTap: () {
                      drawerKey.currentState?.openDrawer();
                    }),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(3.5),
                  child: Observer(builder: (_) {
                    if (authController.user?.image != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(SizeToken.lg),
                        child: Image(
                            image: CachedNetworkImageProvider(
                              authController.user!.image!,
                              maxHeight: 150,
                              maxWidth: 150,
                            ),
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: ColorToken.danger,
                                ),
                              );
                            },
                          ),
                      );
                    }
                    if (authController.user != null) {
                      return Container(
                        height: SizeToken.xl4,
                        width: SizeToken.xl4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorToken.danger,
                        ),
                        alignment: Alignment.center,
                        child: TextLabelL1Light(
                          text: authController.user!.name[0].toUpperCase(),
                        ),
                      );
                    }

                    return IconButtonLargeDark(
                      key: const Key('loginButton'),
                      icon: IconConstant.user,
                      onTap: () async {
                        await authController.login();
                        if (authController.user?.id != null) {
                          await addressController
                              .detailAddressUser(authController.user!.id);
                          await cartItemController
                              .getByGroupStoreByUser(authController.user!.id);
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          )),
      drawer: DrawerMenu(
        firstOnPressed: () {
          controller.onItemTapped(0);
          context.pop();
        },
        secoundOnPressed: () {
          controller.onItemTapped(1);
          context.pop();
        },
        thirdOnPressed: () {
          controller.onItemTapped(2);
          context.pop();
        },
        fourthOnPressed: () async {
          if (authController.user == null) {
            context.push('/login', extra: LoginRedirectEnum.STORE);
            return;
          } else {
            if (authController.store == null) {
              context.push('/store/register');
              return;
            } else {
              await addressController
                  .detailAddressStore(authController.store!.id);
              context.push('/store/my/${authController.store!.id}');
              return;
            }
          }
        },
        fifthOnPressed: () async {
          if (authController.user == null) {
            context.push('/login', extra: LoginRedirectEnum.ADDRESS);
            return;
          } else {
            await addressController.detailAddressUser(authController.user!.id);
            if (addressController.addressUser == null) {
              context.push('/address/register/delivery',
                  extra: authController.user!.id);
              return;
            } else {
              context.push(
                '/address/update/delivery',
                extra: addressController.addressUser,
              );
              return;
            }
          }
        },
        aboutOnPressed: () => context.push('/about'),
        logoutOnPressed: () {
          if (authController.user?.email != null) {
            showCustomModalBottomSheet(
              context: context,
              builder: (context) => ModalSheet(
                iconBack: IconConstant.arrowLeft,
                title: TextConstant.logoutAccountTitle,
                description: TextConstant.logoutAccountMessage(
                    authController.user!.email),
                cancelText: TextConstant.no,
                continueText: TextConstant.yes,
                continueOnTap: () {
                  authController.logout();
                  addressController.clean();
                  cartItemController.clean();
                  context.pop();
                  context.pop();
                },
              ),
            );
          }
        },
        firstText: TextConstant.home,
        secoundText: TextConstant.products,
        thirdText: TextConstant.stores,
        fourthText: TextConstant.myStore,
        fifthText: TextConstant.deliveryAddress,
        aboutText: TextConstant.about,
        logoutText: TextConstant.logout,
        firstIcon: IconConstant.home,
        secoundIcon: IconConstant.search,
        thirdIcon: IconConstant.store,
        fourthIcon: IconConstant.storeAdd,
        fifthIcon: IconConstant.address,
        aboutIcon: IconConstant.about,
        logoutIcon: IconConstant.logout,
        menuIcon: IconConstant.menu,
        logo: ImageConstant.horizontalLogo,
      ),
      body: Observer(builder: (_) {
        return IndexedStack(
          index: controller.currentIndex,
          children: [
            ContentDefault(child: HomeScreenWidget()),
            ContentDefault(child: ProductScreen()),
            ContentDefault(child: StoreScreen()),
            CartScreen(),
          ],
        );
      }),
      bottomNavigationBar: Observer(builder: (_) {
        return ButtonNavigatorMenu(
          currentIndex: controller.currentIndex,
          onTap: controller.onItemTapped,
          firstLabel: TextConstant.home,
          secoundLabel: TextConstant.products,
          thirdLabel: TextConstant.stores,
          fourthLabel: TextConstant.cart,
          firstIcon: IconConstant.home,
          secoundIcon: IconConstant.search,
          thirdIcon: IconConstant.store,
          fourthIcon: IconConstant.cart,
          fourthCount: cartItemController.amountItemCart,
        );
      }),
    );
  }
}
