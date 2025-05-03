import 'package:go_router/go_router.dart';
import 'package:my_fome/src/constants/navigator/navigator_global.dart';
import 'package:my_fome/src/ui/modules/home/pages/home_page.dart';
import 'package:my_fome/src/ui/modules/home/pages/user_not_found_page.dart';
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
      builder: (context, state) => const UserNotFoundPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const UserNotFoundPage(),
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
      builder: (context, state) => const ProductByMyStorePage(),
    ),
    GoRoute(
      path: '/product/register',
      builder: (context, state) => const RegisterProduct(),
    ),
    GoRoute(
      path: '/product/update',
      builder: (context, state) => const UpdateProduct(),
    ),
    GoRoute(
      path: '/store/my',
      builder: (context, state) => const MyStorePage(),
    ),
    GoRoute(
      path: '/store/register',
      builder: (context, state) => const RegisterStore(),
    ),
    GoRoute(
      path: '/store/update',
      builder: (context, state) => const UpdateStore(),
    ),
  ]);
}
