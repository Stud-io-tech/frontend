// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/products/product_register_dto.dart';
import 'package:my_fome/src/domain/dtos/products/product_update_dto.dart';

import 'package:my_fome/src/ui/viewmodels/products/product_view_model.dart';

part 'product_controller.g.dart';

class ProductController = ProductControllerBase with _$ProductController;

abstract class ProductControllerBase with Store {
  final ProductViewModel productViewModel;
  ProductControllerBase({
    required this.productViewModel,
  });

  @computed
  ProductDetailDto? get product => productViewModel.product;

  @computed
  int get activeFounds => productViewModel.foundActive;

  @computed
  int get activeFoundsByStore => productViewModel.foundActiveByStore;

  @computed
  int get inactiveFoundsByStore => productViewModel.foundInactiveByStore;

  @computed
  bool get isLoading => productViewModel.isLoading;

  @computed
  bool get isServerError => productViewModel.serverError;

  @computed
  List<ProductDetailDto>? get productFilterListActive =>
      productViewModel.productFilterListActive;

  @computed
  List<ProductDetailDto>? get productFilterListInactiveByStore =>
      productViewModel.productFilterListInactiveByStore;

  @computed
  List<ProductDetailDto>? get productFilterListActiveByStore =>
      productViewModel.productFilterListActiveByStore;

  Future<void> listProductsActive() async {
    await productViewModel.listActive();
  }

  void filterProducts(String name) {
    productViewModel.listFilterByName(name);
  }

  Future<void> listProductsActiveByStore(String id) async {
    await productViewModel.listActiveByStore(id);
  }

  Future<void> listProductsInactiveByStore(String id) async {
    await productViewModel.listInactiveByStore(id);
  }

  Future<void> register(ProductRegisterDto product, XFile image) async {
    await productViewModel.register(product, image);
  }

  Future<void> update(String id, ProductUpdateDto product, {XFile? image}) async {
    await productViewModel.update(id, product, image: image);
  }

  Future<void> toggleActive(String productId, String storeId) async {
    await productViewModel.toggleActive(productId);
    await listProductsActiveByStore(storeId);
    await listProductsInactiveByStore(storeId);
  }

  Future<void> detailProduct(String id) async {
    await productViewModel.detail(id);
  }
}
