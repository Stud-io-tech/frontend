// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fome/src/constants/api_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/data/exceptions/rest_exception.dart';
import 'package:my_fome/src/domain/repositories/stores/store_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_register_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_update_dto.dart';
import 'package:my_fome/src/data/services/client/client_service.dart';

class StoreRepositoryImpl implements StoreRepository {
  final ClientService clientService;
  StoreRepositoryImpl({
    required this.clientService,
  });

  @override
  AsyncResult<List<StoreDetailDto>> list() async {
    try {
      final Response response = await clientService.get(ApiConstant.store);
      final List<dynamic> resultStores = response.data['stores'];
      final List<StoreDetailDto> storesList = resultStores
          .map((item) => StoreDetailDto.fromMap(item as Map<String, dynamic>))
          .toList();
      return Success(storesList);
    } on DioException catch (e) {
      return Failure(
        RestException(
            message: TextConstant.errorListStoresMessage,
            statusCode: e.response?.statusCode ?? 500),
      );
    }
  }

  @override
  AsyncResult<StoreRegisterDto> register(
      StoreRegisterDto store, XFile image) async {
    try {
      final FormData formDataStore = FormData.fromMap({
        'name': store.name,
        'description': store.description,
        'whatsapp': store.whatsapp,
        'chave_pix': store.chavePix,
        'image': MultipartFile.fromBytes(
          await image.readAsBytes(),
          filename: image.name,
        ),
      });

      final Response response = await clientService.post(
          ApiConstant.store, formDataStore,
          requiresAuth: true, contentType: 'multipart/form-data');

      final StoreRegisterDto resultStore =
          StoreRegisterDto.fromMap(response.data['store']);

      return Success(resultStore);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorCreatingStoreMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<StoreUpdateDto> update(
      String id, StoreUpdateDto store, {XFile? image}) async {
    try {
      final FormData formDataStore = FormData.fromMap({
        'name': store.name,
        'description': store.description,
        'whatsapp': store.whatsapp,
        '_method': 'PUT',
      });

      if (image != null) {
        formDataStore.files.add(MapEntry(
            'image',
            MultipartFile.fromBytes(await image.readAsBytes(),
                filename: image.name)));
      }

      final Response response = await clientService.post(
          "${ApiConstant.store}/$id", formDataStore,
          requiresAuth: true, contentType: 'multipart/form-data');
      final StoreUpdateDto resultStore = StoreUpdateDto.fromMap(response.data['store']);
      return Success(resultStore);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorUpdatingStoreMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<StoreDetailDto> detail(String id) async {
    try {
      final Response response =
          await clientService.get("${ApiConstant.store}/$id");

      final StoreDetailDto resultProduct =
          StoreDetailDto.fromMap(response.data['store']);
      return Success(resultProduct);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorDetailsStoreMessage,
          statusCode: e.hashCode,
        ),
      );
    }
  }
}
