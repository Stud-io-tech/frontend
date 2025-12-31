// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

import 'package:my_fome/src/domain/dtos/address/address_detail_dto.dart';
import 'package:my_fome/src/domain/dtos/address/address_register_dto.dart';
import 'package:my_fome/src/domain/dtos/address/address_update_dto.dart';
import 'package:my_fome/src/ui/viewmodels/address/address_view_model.dart';

part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store {
  final AddressViewModel addressViewModel;
  AddressControllerBase({
    required this.addressViewModel,
  });

  @computed
  bool get isLoading => addressViewModel.isLoading;

  @computed
  bool get isServerError => addressViewModel.serverError;

  @computed
  AddressDetailDto? get address => addressViewModel.address;


  Future<void> detailAddressUser(String id) async {
    await addressViewModel.detailAddressUser(id);
  }

  Future<void> detailAddressStore(String id) async {
    await addressViewModel.detailAddressStore(id);
  }

  Future<void> register(AddressRegisterDto data) async {
    await addressViewModel.register(data);
  }

  Future<void> update(String id, AddressUpdateDto data) async {
    await addressViewModel.update(id, data);
  } 
}
