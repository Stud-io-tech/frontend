// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:latlong2/latlong.dart';
import 'package:mobx/mobx.dart';

import 'package:my_fome/src/data/services/map/map_service.dart';
import 'package:my_fome/src/domain/dtos/address/address_map_dto.dart';

part 'address_map_controller.g.dart';

class AddressMapController = AddressMapControllerBase
    with _$AddressMapController;

abstract class AddressMapControllerBase with Store {
  final MapService mapService;

  AddressMapControllerBase({required this.mapService});

  @observable
  double latitude = -6.47926;

  @observable
  double longitude = -35.4348;

  @observable
  String? searchText;

  @observable
  AddressMapDto? addressMap;

  @action
  void onTapMap(LatLng point) {
    latitude = point.latitude;
    longitude = point.longitude;
  }

  @action
  Future<void> getCurrentPosition() async {
    final position = await mapService.determinePosition();
    latitude = position.latitude;
    longitude = position.longitude;
  }

  @action
  Future<void> searchAddress() async {
    final point = await mapService.searchAddress(searchText);
    if (point != null) {
      latitude = point.latitude;
      longitude = point.longitude;
    }
  }

  @action
  Future<void> reverseAddress(LatLng point) async {
    final Map<String, dynamic>? data = await mapService.reverseAddress(point);
    if (data == null) return;
    addressMap = AddressMapDto(
      cep: data['postcode'],
      state: data['state'],
      city: data['city'] ?? data['town'] ?? data['village'],
      district: data['neighbourhood'] ?? data['suburb'],
      street: data['road'],
    );
  }

  Future<void> getAddressCep(String? cep) async {
    if (addressMap?.cep == null) {
      final Map<String, dynamic>? data = await mapService.cepAddress(cep);
      if (data?['cep'] != null) {
        addressMap = AddressMapDto(
          cep: data!['cep'],
          state: data['estado'],
          city: data['localidade'],
        );
      }
    }
  }

  void cleanAddress() {
    latitude = -6.47926;
    longitude = -35.4348;
  }
}
