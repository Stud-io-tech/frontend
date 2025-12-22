import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

abstract interface class MapService {
  Future<Position> determinePosition();
  Future<LatLng?> searchAddress(String? query);
  Future<Map<String, dynamic>?> reverseAddress(LatLng point);
  Future<Map<String, dynamic>?> cepAddress(String? cep); 
}
