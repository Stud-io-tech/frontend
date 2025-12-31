// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:my_fome/src/constants/api_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';
import 'package:my_fome/src/data/exceptions/rest_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'package:my_fome/src/data/services/client/client_service.dart';
import 'package:my_fome/src/domain/dtos/address/address_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/address/address_register_dto.dart';
import 'package:my_fome/src/domain/dtos/address/address_update_dto.dart';

import '../../../domain/repositories/address/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final ClientService clientService;
  AddressRepositoryImpl({
    required this.clientService,
  });

  @override
  AsyncResult<List<AddressDetailDto>> detailAddressUser(String id) async {
    try {
      final Response response = await clientService.get(
        "${ApiConstant.address}/user/$id",
        requiresAuth: true,
      );
      final List<dynamic> resultAddress = response.data['address'];

      final List<AddressDetailDto> addressList = resultAddress
          .map((item) => AddressDetailDto.fromMap(item as Map<String, dynamic>))
          .toList();

      return Success(addressList);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorDetailsUserMessage,
          statusCode: e.hashCode,
        ),
      );
    }
  }

  @override
  AsyncResult<List<AddressDetailDto?>> detailAddressStore(String id) async {
    try {
      final Response response = await clientService.get(
        "${ApiConstant.address}/store/$id"
      );

      final List<dynamic> resultAddress = response.data['address'];

      final List<AddressDetailDto> addressList = resultAddress
          .map((item) => AddressDetailDto.fromMap(item as Map<String, dynamic>))
          .toList();

      return Success(addressList);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorDetailsUserMessage,
          statusCode: e.hashCode,
        ),
      );
    }
  }

  @override
  AsyncResult<AddressDetailDto> register(AddressRegisterDto data) async {
    try {
      final Response response = await clientService.post(
        ApiConstant.address,
        data.toMap(),
        requiresAuth: true,
      );
      final AddressDetailDto addresRegister =
          AddressDetailDto.fromMap(response.data['address']);
      return Success(addresRegister);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorCreatingAddressMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }

  @override
  AsyncResult<AddressDetailDto> update(String id, AddressUpdateDto data) async {
    try {
      final Response response = await clientService.put(
        "${ApiConstant.address}/$id",
        data.toMap(),
        requiresAuth: true,
      );
      final AddressDetailDto addressUpdate =
          AddressDetailDto.fromMap(response.data['address']);
      return Success(addressUpdate);
    } on DioException catch (e) {
      return Failure(
        RestException(
          message: TextConstant.errorCreatingAddressMessage,
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    }
  }
}
