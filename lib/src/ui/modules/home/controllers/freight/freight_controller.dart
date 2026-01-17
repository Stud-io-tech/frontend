import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
part 'freight_controller.g.dart';

class FreightController = FreightControllerBase with _$FreightController;

abstract class FreightControllerBase with Store {
  @action
  List<double> getFreight(double userLatitude, double userLongitude,
      double storeLatitude, double storeLongitude, double valueKM) {
    double distanceInMeters = Geolocator.distanceBetween(
        userLatitude, userLongitude, storeLatitude, storeLongitude);

    double distanceKm = distanceInMeters / 1000;

    double freight = valueKM * distanceKm;

    return [distanceKm, freight];
  }
}
