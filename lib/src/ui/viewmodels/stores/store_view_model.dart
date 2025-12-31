// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:my_fome/src/constants/icon_constant.dart';
import 'package:my_fome/src/constants/text_constant.dart';

import 'package:my_fome/src/data/services/messages/result_message_service.dart';
import 'package:my_fome/src/domain/dtos/stores/store_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_register_dto.dart';
import 'package:my_fome/src/domain/dtos/stores/store_update_dto.dart';
import 'package:my_fome/src/domain/repositories/stores/store_repository.dart';

part 'store_view_model.g.dart';

class StoreViewModel = StoreViewModelBase with _$StoreViewModel;

abstract class StoreViewModelBase with Store {
  final StoreRepository storeRepository;
  final ResultMessageService resultMessageService;
  StoreViewModelBase({
    required this.storeRepository,
    required this.resultMessageService,
  });

  @observable
  bool isLoading = false;

  @observable
  List<StoreDetailDto>? storesList;

  @observable
  List<StoreDetailDto>? storeFilterList;

  @observable
  StoreDetailDto? store;

  @observable
  int founds = 0;

  @observable
  bool serverError = false;

  @action
  Future list() async {
    isLoading = true;
    final result = await storeRepository.list();
    result.fold((success) {
      serverError = false;
      storesList = success;
      storeFilterList = storesList;
      founds = storeFilterList?.length ?? 0;
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorListStoresMessage);
    });
    isLoading = false;
  }

  @action
  Future<void> listFilterByName(String name) async {
    if (name.isNotEmpty) {
      storeFilterList = storesList
          ?.where((element) =>
              element.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
      founds = storeFilterList?.length ?? 0;
    } else {
      storeFilterList = storesList;
      founds = storeFilterList?.length ?? 0;
    }
  }

  @action
  Future register(StoreRegisterDto store, XFile image) async {
    isLoading = true;
    final result = await storeRepository.register(store, image);
    result.fold((success) {
      serverError = false;
      resultMessageService.showMessageSuccess(
          TextConstant.sucessCreatingStoreTitle,
          TextConstant.sucessCreatingStoreMessage,
          IconConstant.success);
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorCreatingStoreMessage);
    });
    isLoading = false;
  }

  @action
  Future update(String id, StoreUpdateDto store, {XFile? image}) async {
    isLoading = true;
    final result = await storeRepository.update(id, store, image: image);
    result.fold((success) {
      serverError = false;
      resultMessageService.showMessageSuccess(
          TextConstant.sucessUpdatingStoreTitle,
          TextConstant.sucessUpdatingStoreMessage,
          IconConstant.edit);
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorUpdatingStoreMessage);
    });
    isLoading = false;
  }

  @action
  Future changeStatusOpen(String id) async {
    isLoading = true;
    final result = await storeRepository.changeStatusOpen(id);
    result.fold((success) {
      serverError = false;
      resultMessageService.showMessageSuccess(
          TextConstant.sucessUpdatingStoreTitle,
          TextConstant.sucessUpdatingStoreMessage,
          IconConstant.edit);
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorUpdatingStoreMessage);
    });
    isLoading = false;
  }

  @action
  Future toggleActive(String id) async {
    isLoading = true;
    final result = await storeRepository.toggleActive(id);
    result.fold((success) {
      serverError = false;
      resultMessageService.showMessageSuccess(
          TextConstant.sucessUpdatingStoreTitle,
          TextConstant.sucessUpdatingStoreMessage,
          IconConstant.edit);
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorUpdatingStoreMessage);
    });
    isLoading = false;
  }

  @action
  Future detail(String id) async {
    isLoading = true;
    final result = await storeRepository.detail(id);
    result.fold((success) {
      serverError = false;
      store = success;
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorDetailsStoreMessage);
    });
    isLoading = false;
  }
}
