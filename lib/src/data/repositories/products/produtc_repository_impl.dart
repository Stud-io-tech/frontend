// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fome/src/constants/api_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/data/exceptions/rest_exception.dart';
import 'package:result_dart/result_dart.dart';

import 'package:my_fome/src/domain/dtos/products/product_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/products/product_register_dto.dart';
import 'package:my_fome/src/domain/dtos/products/product_update_dto.dart';
import 'package:my_fome/src/data/services/client/client_service.dart';

import '../../../domain/repositories/products/produtc_repository.dart';

class ProdutcRepositoryImpl implements ProdutcRepository {
  final ClientService clientService;
  ProdutcRepositoryImpl({
    required this.clientService,
  });

  @override
  AsyncResult<List<ProductDetailDto>> listActive() async {
    try {
      final Response response = await clientService.get(ApiConstant.product);
      final List<dynamic> resultProducts = response.data['products'];
      final List<ProductDetailDto> productsList = resultProducts
          .map((item) => ProductDetailDto.fromMap(item as Map<String, dynamic>))
          .toList();
      return Success(productsList);
    } on DioException catch (e) {
      return Failure(
        RestException(
            message: TextConstant.errorListProductsMessage,
            statusCode: e.response?.statusCode ?? 500),
      );
    }
  }

  @override
  AsyncResult<ProductRegisterDto> register(
      ProductRegisterDto product, XFile image) async {
    try {
      final FormData formDataProduct = FormData.fromMap({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'amount': product.amount,
        'store_id': product.storeId,
        'is_perishable': product.isPerishable,
        'preparation_time': product.preparationTime,
        'image': MultipartFile.fromBytes(
          await image.readAsBytes(),
          filename: image.name,
        ),
      });
      final Response response = await clientService.post(
          ApiConstant.product, formDataProduct,
          requiresAuth: true, contentType: 'multipart/form-data');
      final ProductRegisterDto resultProduct =
          ProductRegisterDto.fromMap(response.data['product']);
      return Success(resultProduct);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorCreatingProductMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<ProductUpdateDto> update(String id, ProductUpdateDto product,
      {XFile? image}) async {
    try {
      final FormData formDataProduct = FormData.fromMap({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'amount': product.amount,
        'store_id': product.storeId,
        '_method': 'PUT',
      });
      if (image != null) {
        formDataProduct.files.add(MapEntry(
            'image',
            MultipartFile.fromBytes(await image.readAsBytes(),
                filename: image.name)));
      }
      final Response response = await clientService.post(
          "${ApiConstant.product}/$id", formDataProduct,
          requiresAuth: true, contentType: 'multipart/form-data');
      final ProductUpdateDto resultProduct =
          ProductUpdateDto.fromMap(response.data['product']);
      return Success(resultProduct);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorUpdatingProductMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<ProductDetailDto> toggleActive(String id) async {
    try {
      final Response response = await clientService
          .put("${ApiConstant.product}/active/$id", requiresAuth: true);
      final ProductDetailDto resultProduct =
          ProductDetailDto.fromMap(response.data['product']);
      return Success(resultProduct);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorExecutingProductMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<List<ProductDetailDto>> listActiveByStore(String id) async {
    try {
      final Response response =
          await clientService.get("${ApiConstant.product}?store=$id");
      final List<dynamic> resultProducts = response.data['products'];
      final List<ProductDetailDto> productsList = resultProducts
          .map((item) => ProductDetailDto.fromMap(item as Map<String, dynamic>))
          .toList();
      return Success(productsList);
    } on DioException catch (e) {
      return Failure(
        RestException(
            message: TextConstant.errorListProductsMessage,
            statusCode: e.response?.statusCode ?? 500),
      );
    }
  }

  @override
  AsyncResult<List<ProductDetailDto>> listInactiveByStore(String id) async {
    try {
      final Response response = await clientService
          .get("${ApiConstant.product}/disabled/$id", requiresAuth: true);
      final List<dynamic> resultProducts = response.data['products'];
      final List<ProductDetailDto> productsList = resultProducts
          .map((item) => ProductDetailDto.fromMap(item as Map<String, dynamic>))
          .toList();
      return Success(productsList);
    } on DioException catch (e) {
      return Failure(
        RestException(
            message: TextConstant.errorListProductsMessage,
            statusCode: e.response?.statusCode ?? 500),
      );
    }
  }

  @override
  AsyncResult<ProductDetailDto> detail(String id) async {
    try {
      final Response response =
          await clientService.get("${ApiConstant.product}/$id");

      final ProductDetailDto resultProduct =
          ProductDetailDto.fromMap(response.data['product']);
      return Success(resultProduct);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorDetailsProductMessage,
          statusCode: e.hashCode,
        ),
      );
    }
  }
}
