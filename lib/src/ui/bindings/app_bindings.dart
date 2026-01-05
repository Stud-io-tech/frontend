import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_fome/src/constants/navigator/navigator_global.dart';
import 'package:my_fome/src/data/repositories/address/address_repository_impl.dart';
import 'package:my_fome/src/data/repositories/cartItem/cart_item_repository_impl.dart';
import 'package:my_fome/src/data/repositories/products/produtc_repository_impl.dart';
import 'package:my_fome/src/data/repositories/stores/store_repository_impl.dart';
import 'package:my_fome/src/data/repositories/users/user_repository_impl.dart';
import 'package:my_fome/src/data/services/auth/auth_google_service.dart';
import 'package:my_fome/src/data/services/auth/auth_google_service_impl.dart';
import 'package:my_fome/src/data/services/client/client_service.dart';
import 'package:my_fome/src/data/services/client/client_service_impl.dart';
import 'package:my_fome/src/data/services/local/local_storage_service.dart';
import 'package:my_fome/src/data/services/local/local_storage_service_impl.dart';
import 'package:my_fome/src/data/services/map/map_service.dart';
import 'package:my_fome/src/data/services/map/map_service_impl.dart';
import 'package:my_fome/src/data/services/messages/result_message_service.dart';
import 'package:my_fome/src/data/services/messages/result_message_service_impl.dart';
import 'package:my_fome/src/data/services/payments/payment_service.dart';
import 'package:my_fome/src/data/services/payments/payment_service_impl.dart';
import 'package:my_fome/src/data/services/share/share_service.dart';
import 'package:my_fome/src/data/services/share/share_service_impl.dart';
import 'package:my_fome/src/data/services/storage/cloudnary/cloudinary_storage_service.dart';
import 'package:my_fome/src/data/services/storage/cloudnary/cloudinary_storage_service_impl.dart';
import 'package:my_fome/src/domain/repositories/address/address_repository.dart';
import 'package:my_fome/src/domain/repositories/cartItem/cart_item_repository.dart';
import 'package:my_fome/src/domain/repositories/products/produtc_repository.dart';
import 'package:my_fome/src/domain/repositories/stores/store_repository.dart';
import 'package:my_fome/src/domain/repositories/users/user_repository.dart';
import 'package:my_fome/src/ui/controllers/address/address_controller.dart';
import 'package:my_fome/src/ui/controllers/auth/auth_google_controller.dart';
import 'package:my_fome/src/ui/controllers/cartItem/cart_item_controller.dart';
import 'package:my_fome/src/ui/controllers/product/product_controller.dart';
import 'package:my_fome/src/ui/controllers/store/store_controller.dart';
import 'package:my_fome/src/ui/controllers/switch/switch_controller.dart';
import 'package:my_fome/src/ui/controllers/upload/local/local_upload_controller.dart';
import 'package:my_fome/src/ui/controllers/upload/remote/remote_upload_controller.dart';
import 'package:my_fome/src/ui/modules/address/controller/address_map_controller.dart';
import 'package:my_fome/src/ui/viewmodels/address/address_view_model.dart';
import 'package:my_fome/src/ui/viewmodels/cartItem/cart_item_view_model.dart';
import 'package:my_fome/src/ui/viewmodels/products/product_view_model.dart';
import 'package:my_fome/src/ui/viewmodels/stores/store_view_model.dart';
import 'package:my_fome/src/ui/viewmodels/users/auth_view_model.dart';

/*         Bind.singleton<FileService>(
          (i) => FileServiceImpl(paymentService: i(), shareService: i()),
        ), */

class AppBindings extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.singleton<LocalStorageService>((i) =>
            LocalStorageServiceImpl(storage: const FlutterSecureStorage())),
        Bind.singleton<ResultMessageService>(
          (i) => ResultMessageServiceImpl(
            navigatorKey: NavigatorGlobal.navigatorKey,
          ),
        ),
        Bind.singleton<ClientService>((i) => ClientServiceImpl(i())),
        Bind.singleton<AuthGoogleService>((i) => AuthGoogleServiceImpl()),
        Bind.singleton<UserRepository>(
            (i) => UserRepositoryImpl(clientService: i())),
        Bind.singleton<ShareService>(
          (i) =>
              ShareServiceImpl(clientService: i(), resultMessageService: i()),
        ),
        Bind.singleton<PaymentService>(
          (i) => PaymentServiceImpl(
            clientService: i(),
          ),
        ),
        Bind.singleton((i) => AuthViewModel(
            userRepository: i(),
            authGoogleService: i(),
            localStorageService: i(),
            resultMessageService: i())),
        Bind.singleton((i) => AuthGoogleController(authViewModel: i())),
        Bind.lazySingleton<ProdutcRepository>(
          (i) => ProdutcRepositoryImpl(
            clientService: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => ProductViewModel(
            productRepository: i(),
            resultMessageService: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => ProductController(
            productViewModel: i(),
          ),
        ),
        Bind.lazySingleton<StoreRepository>(
          (i) => StoreRepositoryImpl(
            clientService: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => StoreViewModel(
            storeRepository: i(),
            resultMessageService: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => StoreController(
            storeViewModel: i(),
          ),
        ),
        Bind.lazySingleton<AddressRepository>(
          (i) => AddressRepositoryImpl(
            clientService: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => AddressViewModel(
            addressRepository: i(),
            resultMessageService: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => AddressController(
            addressViewModel: i(),
          ),
        ),
        Bind.lazySingleton<CartItemRepository>(
          (i) => CartItemRepositoryImpl(
            clientService: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => CartItemViewModel(
            cartItemRepository: i(),
            resultMessageService: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => CartItemController(
            cartItemViewModel: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => LocalUploadController(),
        ),
        Bind.lazySingleton<CloudinaryStorageService>(
          (i) => CloudinaryStorageServiceImpl(),
        ),
        Bind.lazySingleton(
          (i) => RemoteUploadController(
            cloudinaryStorageService: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => SwitchController(),
        ),
        Bind.lazySingleton<MapService>(
          (i) => MapServiceImpl(
            clientService: i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => AddressMapController(
            mapService: i(),
          ),
        ),
      ];
}
