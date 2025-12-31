import 'package:image_picker/image_picker.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_register_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_update_dto.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class StoreRepository {
  AsyncResult<List<StoreDetailDto>> list();
  AsyncResult<StoreRegisterDto> register(StoreRegisterDto store, XFile image);
  AsyncResult<StoreUpdateDto> update(String id, StoreUpdateDto store,
      {XFile? image});
  AsyncResult<StoreDetailDto> detail(String id);
  AsyncResult<StoreDetailDto> toggleActive(String id);
  AsyncResult<StoreDetailDto> changeStatusOpen(String id);
}
