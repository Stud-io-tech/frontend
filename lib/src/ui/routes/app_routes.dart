import 'package:go_router/go_router.dart';
import 'package:my_fome/src/constants/navigator/navigator_global.dart';
import 'package:my_fome/src/domain/dtos/address/address_user_register_dto.dart';
import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/domain/enum/login_redirect_enum.dart';
import 'package:my_fome/src/ui/modules/address/pages/delivery/register_address_delivery_page.dart';
import 'package:my_fome/src/ui/modules/address/pages/delivery/update_address_delivery_page.dart';
import 'package:my_fome/src/ui/modules/home/pages/home_page.dart';
import 'package:my_fome/src/ui/modules/home/pages/user_not_found_page.dart';
import 'package:my_fome/src/ui/modules/home/widgets/screens/order_pdf_screen_widget.dart';
import 'package:my_fome/src/ui/modules/home/widgets/screens/product_detail_screen_widget.dart';
import 'package:my_fome/src/ui/modules/home/widgets/screens/store_detail_screen_widget.dart';
import 'package:my_fome/src/ui/modules/product/pages/product_by_my_store_page.dart';
import 'package:my_fome/src/ui/modules/product/widgets/register/register_product.dart';
import 'package:my_fome/src/ui/modules/product/widgets/update/update_product.dart';
import 'package:my_fome/src/ui/modules/store/pages/my_store_page_widget.dart';
import 'package:my_fome/src/ui/modules/store/widgets/register/register_store.dart';
import 'package:my_fome/src/ui/modules/store/widgets/update/update_store.dart';

sealed class AppRoutes {
  static final GoRouter route =
      GoRouter(navigatorKey: NavigatorGlobal.navigatorKey, routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => UserNotFoundPage(
        loginRedirectEnum: state.extra as LoginRedirectEnum,
      ),
    ),
    GoRoute(
      path: '/product-detail/:id',
      builder: (context, state) => ProductDetailScreenWidget(
        id: state.pathParameters['id'],
      ),
    ),
    GoRoute(
      path: '/store-detail/:id',
      builder: (context, state) => StoreDetailScreenWidget(
        id: state.pathParameters['id'],
      ),
    ),
    GoRoute(
      path: '/product/my',
      builder: (context, state) => ProductByMyStorePage(
        store: state.extra as StoreDetailDto,
      ),
    ),
    GoRoute(
      path: '/product/register',
      builder: (context, state) => RegisterProduct(
        store: state.extra as StoreDetailDto,
      ),
    ),
    GoRoute(
      path: '/product/update',
      builder: (context, state) => UpdateProduct(
        product: state.extra as ProductDetailDto,
      ),
    ),
    GoRoute(
      path: '/store/my/:id',
      builder: (context, state) => MyStorePage(id: state.pathParameters['id']),
    ),
    GoRoute(
      path: '/store/register',
      builder: (context, state) => const RegisterStore(),
    ),
    GoRoute(
      path: '/store/update',
      builder: (context, state) => UpdateStore(
        store: state.extra as StoreDetailDto,
      ),
    ),
    GoRoute(
      path: '/order-pdf',
      builder: (context, state) {
        final extras = state.extra as Map<String, String>;
        return OrderPdfScreenWidget(
          path: extras['path']!,
          whatsapp: extras['whatsapp']!,
          code: extras['code']!,
        );
      },
    ),
    GoRoute(
      path: '/address/register/delivery',
      builder: (context, state) => RegisterAddressDeliveryPage(
        userId: state.extra.toString(),
      ),
    ),
    GoRoute(
      path: '/address/update/delivery',
      builder: (context, state) => UpdateAddressDeliveryPage(address: state.extra as AddressUserRegisterDto,),
    ),
  ]);
}
