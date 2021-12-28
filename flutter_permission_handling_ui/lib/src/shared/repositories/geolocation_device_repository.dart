import 'package:geolocator/geolocator.dart';

abstract class GeolocationDeviceRepository {
  Stream<Position> streamPosition();
}

class GeolocationDeviceRepositoryImpl implements GeolocationDeviceRepository {
  @override
  Stream<Position> streamPosition() {
    return GeolocatorPlatform.instance.getPositionStream();
  }
}
