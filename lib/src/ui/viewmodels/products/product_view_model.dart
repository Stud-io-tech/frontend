import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/data/services/messages/result_message_service.dart';
import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/products/product_register_dto.dart';
import 'package:my_fome/src/domain/dtos/products/product_update_dto.dart';
import 'package:my_fome/src/domain/repositories/products/produtc_repository.dart';
part 'product_view_model.g.dart';

class ProductViewModel = ProductViewModelBase with _$ProductViewModel;

abstract class ProductViewModelBase with Store {
  final ProdutcRepository productRepository;
  final ResultMessageService resultMessageService;
  ProductViewModelBase({
    required this.productRepository,
    required this.resultMessageService,
  });

  @observable
  bool isLoading = false;

  @observable
  List<ProductDetailDto>? productsListActive;

  @observable
  List<ProductDetailDto>? productsListInactiveByStore;

  @observable
  List<ProductDetailDto>? productsListActiveByStore;

  @observable
  List<ProductDetailDto>? productFilterListActive;

  @observable
  List<ProductDetailDto>? productFilterListInactiveByStore;

  @observable
  List<ProductDetailDto>? productFilterListActiveByStore;

  @observable
  ProductDetailDto? product;

  @observable
  int foundActive = 0;

  @observable
  int foundActiveByStore = 0;

  @observable
  int foundInactiveByStore = 0;

  @observable
  bool serverError = false;

  @action
  Future listActive() async {
    isLoading = true;
    final result = await productRepository.listActive();
    result.fold((success) {
      serverError = false;
      productsListActive = success;
      productFilterListActive = productsListActive;
      foundActive = productFilterListActive?.length ?? 0;
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorListProductsMessage);
    });
    isLoading = false;
  }

  @action
  void listFilterByName(String name) {
    if (name.isNotEmpty) {
      productFilterListActive = productsListActive
          ?.where((element) =>
              element.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
      productFilterListInactiveByStore = productsListInactiveByStore
          ?.where((element) =>
              element.name.toLowerCase().contains(name.toLowerCase()))
          .toList();

      productFilterListActiveByStore = productsListActiveByStore
          ?.where((element) =>
              element.name.toLowerCase().contains(name.toLowerCase()))
          .toList();

      foundActive = productFilterListActive?.length ?? 0;
      foundActiveByStore = productFilterListActiveByStore?.length ?? 0;
      foundInactiveByStore = productFilterListInactiveByStore?.length ?? 0;
    } else {
      productFilterListActive = productsListActive;
      productFilterListActiveByStore = productsListActiveByStore;
      productFilterListInactiveByStore = productsListInactiveByStore;

      foundActive = productFilterListActive?.length ?? 0;
      foundInactiveByStore = productFilterListInactiveByStore?.length ?? 0;
      foundActiveByStore = productFilterListActiveByStore?.length ?? 0;
    }
  }

  @action
  Future register(ProductRegisterDto product, XFile image) async {
    isLoading = true;
    final result = await productRepository.register(product, image);
    result.fold((success) {
      serverError = false;
      resultMessageService.showMessageSuccess(
          TextConstant.sucessCreatingProductTitle,
          TextConstant.sucessCreatingProductMessage,
          IconConstant.success);
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorCreatingProductMessage);
    });
    isLoading = false;
  }

  @action
  Future update(String id, ProductUpdateDto product, {XFile? image}) async {
    isLoading = true;
    final result = await productRepository.update(id, product, image: image);
    result.fold((success) {
      serverError = false;
      resultMessageService.showMessageSuccess(
          TextConstant.sucessUpdatingProductTitle,
          TextConstant.sucessUpdatingProductMessage,
          IconConstant.edit);
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorUpdatingProductMessage);
    });
    isLoading = false;
  }

  Future toggleActive(String id) async {
    isLoading = true;
    final result = await productRepository.toggleActive(id);
    result.fold((success) {
      serverError = false;
      if (success.active) {
        resultMessageService.showMessageSuccess(
            TextConstant.sucessRestoreProductTitle,
            TextConstant.sucessRestoreProductMessage,
            IconConstant.restore);
      } else {
        resultMessageService.showMessageSuccess(
            TextConstant.sucessSuspendingProductTitle,
            TextConstant.sucessSuspendingProductMessage,
            IconConstant.remove);
      }
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorExecutingProductMessage);
    });
    isLoading = false;
  }

  Future listActiveByStore(String id) async {
    isLoading = true;
    final result = await productRepository.listActiveByStore(id);
    result.fold((success) {
      serverError = false;
      productsListActiveByStore = success;
      productFilterListActiveByStore = productsListActiveByStore;
      foundActiveByStore = productsListActiveByStore?.length ?? 0;
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorListProductsMessage);
    });
    isLoading = false;
  }

  @action
  Future listInactiveByStore(String id) async {
    isLoading = true;
    final result = await productRepository.listInactiveByStore(id);
    result.fold((success) {
      serverError = false;
      productsListInactiveByStore = success;
      productFilterListInactiveByStore = productsListInactiveByStore;
      foundInactiveByStore = productFilterListInactiveByStore?.length ?? 0;
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorListProductsMessage);
    });
    isLoading = false;
  }

  @action
  Future detail(String id) async {
    isLoading = true;
    final result = await productRepository.detail(id);
    result.fold((success) {
      serverError = false;
      product = success;
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorDetailsStoreMessage);
    });
    isLoading = false;
  }
}
