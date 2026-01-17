// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_fome/src/constants/api_constant.dart';

import 'package:my_fome/src/data/services/client/client_service.dart';

import './map_service.dart';

class MapServiceImpl implements MapService {
  final ClientService clientService;
  MapServiceImpl({
    required this.clientService,
  });

  @override
  Future<Position> determinePosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied.');
    }

    return Geolocator.getCurrentPosition();
  }

  @override
  Future<LatLng?> searchAddress(String? query) async {
    try {
      final Response response = await clientService.get(
        ApiConstant.searchOSM(query),
        headers: {
          'User-Agent': ApiConstant.userAgent,
          'Accept': 'application/json',
        },
      );
      final resultData = response.data as List;
      if (resultData.isEmpty) return null;
      return LatLng(
        double.parse(resultData.first['lat']),
        double.parse(resultData.first['lon']),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> reverseAddress(LatLng point) async {
    try {
      final Response response = await clientService.get(
        ApiConstant.reverseLatLng(point.latitude, point.longitude),
        headers: {
          'User-Agent': ApiConstant.userAgent,
          'Accept': 'application/json',
        },
      );
      return response.data['address'];
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> cepAddress(String? cep) async {
    try {
      final Response response = await clientService.get(
        ApiConstant.baseViaCep(cep),
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }

  @override
  String getLocalOpenMapLink(double latitude, double longitude) {
    return ApiConstant.baseOpenMapLinkGoogle(latitude, longitude);
  }
}
