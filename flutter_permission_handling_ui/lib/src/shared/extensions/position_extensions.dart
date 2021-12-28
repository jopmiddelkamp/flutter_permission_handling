import 'package:flutter_permission_handling_core/flutter_permission_handling_core.dart';
import 'package:geolocator/geolocator.dart';

extension PositionX on Position {
  Geolocation toGeolocation() {
    return Geolocation(
      latitude,
      longitude,
    );
  }
}
