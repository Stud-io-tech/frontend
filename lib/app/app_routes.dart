import 'package:go_router/go_router.dart';
import 'package:my_fome/app/domain/dtos/address/address_detail_dto.dart';
import 'package:my_fome/app/domain/dtos/cartItem/cart_item_group_store_dto.dart';
import 'package:my_fome/app/domain/dtos/products/product_detail_dto.dart';
import 'package:my_fome/app/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/app/domain/enum/login_redirect_enum.dart';
import 'package:my_fome/app/presentation/modules/address/pages/delivery/register_address_delivery_page.dart';
import 'package:my_fome/app/presentation/modules/address/pages/delivery/update_address_delivery_page.dart';
import 'package:my_fome/app/presentation/modules/address/pages/store/register_address_store_page.dart';
import 'package:my_fome/app/presentation/modules/address/pages/store/update_address_store_page.dart';
import 'package:my_fome/app/presentation/modules/home/pages/about_page.dart';
import 'package:my_fome/app/presentation/modules/home/pages/home_page.dart';
import 'package:my_fome/app/presentation/modules/home/pages/splash_page.dart';
import 'package:my_fome/app/presentation/modules/home/pages/user_not_found_page.dart';
import 'package:my_fome/app/presentation/modules/home/widgets/screens/order_pdf_screen_widget.dart';
import 'package:my_fome/app/presentation/modules/home/widgets/screens/product_detail_screen_widget.dart';
import 'package:my_fome/app/presentation/modules/home/widgets/screens/store_detail_screen_widget.dart';
import 'package:my_fome/app/presentation/modules/product/pages/product_by_my_store_page.dart';
import 'package:my_fome/app/presentation/modules/product/widgets/register/register_product.dart';
import 'package:my_fome/app/presentation/modules/product/widgets/screen/my_product_detail_screen.dart';
import 'package:my_fome/app/presentation/modules/product/widgets/update/update_product.dart';
import 'package:my_fome/app/presentation/modules/store/pages/my_store_page_widget.dart';
import 'package:my_fome/app/presentation/modules/store/widgets/register/register_store.dart';
import 'package:my_fome/app/presentation/modules/store/widgets/update/update_store.dart';
import 'package:my_fome/app/utils/navigator/navigator_global.dart';

sealed class AppRoutes {
  static final GoRouter route =
      GoRouter(navigatorKey: NavigatorGlobal.navigatorKey, routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
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
        productModel: state.extra as ProductDetailDto,
        id: state.pathParameters['id'],
      ),
    ),
    GoRoute(
      path: '/my-product-detail',
      builder: (context, state) => MyProductDetailScreen(
        product: state.extra as ProductDetailDto,
      ),
    ),
    GoRoute(
      path: '/store-detail/:id',
      builder: (context, state) => StoreDetailScreenWidget(
        storeModel: state.extra as StoreDetailDto,
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
      path: '/about',
      builder: (context, state) => AboutPage(),
    ),
    GoRoute(
      path: '/order-pdf',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;

        return OrderPdfScreenWidget(
          cartItemGroupStoreDto: extras['cart'] as CartItemGroupStoreDto,
          addressUser: extras['address'] as AddressDetailDto,
          userName: extras['userName'] as String,
          userId: extras['userId'] as String,
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
      builder: (context, state) => UpdateAddressDeliveryPage(
        address: state.extra as AddressDetailDto,
      ),
    ),
    GoRoute(
      path: '/address/register/store',
      builder: (context, state) => RegisterAddressStorePage(
        storeId: state.extra.toString(),
      ),
    ),
    GoRoute(
      path: '/address/update/store',
      builder: (context, state) => UpdateAddressStorePage(
        address: state.extra as AddressDetailDto,
      ),
    ),
  ]);
}
