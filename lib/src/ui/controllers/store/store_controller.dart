// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_register_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_update_dto.dart';

import 'package:my_fome/src/ui/viewmodels/stores/store_view_model.dart';

part 'store_controller.g.dart';

class StoreController = StoreControllerBase with _$StoreController;

abstract class StoreControllerBase with Store {
  final StoreViewModel storeViewModel;
  StoreControllerBase({
    required this.storeViewModel,
  });

  @computed
  int get founds => storeViewModel.founds;

  @computed
  bool get isLoading => storeViewModel.isLoading;

  @computed
  bool get isServerError => storeViewModel.serverError;

  @computed
  List<StoreDetailDto>? get stores => storeViewModel.storeFilterList;

  @computed
  StoreDetailDto? get store => storeViewModel.store;

  Future<void> listStore() async {
    await storeViewModel.list();
  }

  void filterStores(String name) {
    storeViewModel.listFilterByName(name);
  }

  Future<void> detailStore(String id) async {
    await storeViewModel.detail(id);
  }

  Future<void> register(StoreRegisterDto store, XFile image) async {
    await storeViewModel.register(store, image);
  }

  Future<void> update(String id, StoreUpdateDto store, {XFile? image}) async {
    await storeViewModel.update(id, store, image: image);
    await detailStore(id);
  }

  Future<void> changeStatusOpen(String id) async {
    await storeViewModel.changeStatusOpen(id);
    await detailStore(id);
  }

  Future<void> toggleActive(String id) async {
    await storeViewModel.toggleActive(id);
    await detailStore(id);
  }
}
