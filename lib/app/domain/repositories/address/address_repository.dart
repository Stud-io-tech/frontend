import 'package:my_fome/app/domain/dtos/address/address_detail_dto.dart';
import 'package:my_fome/app/domain/dtos/address/address_register_dto.dart';
import 'package:my_fome/app/domain/dtos/address/address_update_dto.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class AddressRepository {
  AsyncResult<AddressDetailDto> update(String id, AddressUpdateDto data);
  AsyncResult<AddressDetailDto> register(AddressRegisterDto data);
  AsyncResult<List<AddressDetailDto?>> detailAddressStore(String id);
  AsyncResult<List<AddressDetailDto?>> detailAddressUser(String id);
}
