// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';
import 'package:my_fome/app/utils/constants/icon_constant.dart';
import 'package:my_fome/app/utils/constants/text_constant.dart';
import 'package:my_fome/app/data/services/messages/result_message_service.dart';

import 'package:my_fome/app/domain/dtos/address/address_detail_dto.dart';
import 'package:my_fome/app/domain/dtos/address/address_register_dto.dart';
import 'package:my_fome/app/domain/dtos/address/address_update_dto.dart';
import 'package:my_fome/app/domain/repositories/address/address_repository.dart';

part 'address_view_model.g.dart';

class AddressViewModel = AddressViewModelBase with _$AddressViewModel;

abstract class AddressViewModelBase with Store {
  final AddressRepository addressRepository;
  final ResultMessageService resultMessageService;
  AddressViewModelBase(
      {required this.addressRepository, required this.resultMessageService});

  @observable
  bool isLoading = false;

  @observable
  AddressDetailDto? address;

  @observable
  bool serverError = false;

  @action
  Future register(AddressRegisterDto data) async {
    isLoading = true;
    final result = await addressRepository.register(data);
    result.fold((success) {
      serverError = false;
      resultMessageService.showMessageSuccess(
          TextConstant.sucessCreatingAddressTitle,
          TextConstant.sucessCreatingAddressMessage,
          IconConstant.success);
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorCreatingAddressMessage);
    });
    isLoading = false;
  }

  @action
  Future update(String id, AddressUpdateDto data) async {
    isLoading = true;
    final result = await addressRepository.update(id, data);
    result.fold((success) {
      serverError = false;
      resultMessageService.showMessageSuccess(
          TextConstant.sucessUpdatingAddressTitle,
          TextConstant.sucessUpdatingAddressMessage,
          IconConstant.edit);
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorUpdatingAddressMessage);
    });
    isLoading = false;
  }

  @action
  Future detailAddressUser(String id) async {
    isLoading = true;
    final result = await addressRepository.detailAddressUser(id);
    result.fold((success) {
      serverError = false;
      if (success.isNotEmpty) {
        address = success.first;
      }
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorDetailsAddressMessage);
    });
    isLoading = false;
  }

  @action
  Future detailAddressStore(String id) async {
    isLoading = true;
    final result = await addressRepository.detailAddressStore(id);
    result.fold((success) {
      serverError = false;
      if (success.isNotEmpty) {
        address = success.first;
      }
    }, (failure) {
      serverError = true;
      resultMessageService
          .showMessageError(TextConstant.errorDetailsAddressMessage);
    });
    isLoading = false;
  }
}
