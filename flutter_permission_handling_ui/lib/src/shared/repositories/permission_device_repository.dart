import 'package:permission_handler/permission_handler.dart';

abstract class PermissionDeviceRepository {
  Future<PermissionStatus> getLocationStatus();
  Future<PermissionStatus> requestLocation();
}

class PermissionDeviceRepositoryImpl implements PermissionDeviceRepository {
  @override
  Future<PermissionStatus> getLocationStatus() {
    return Permission.locationWhenInUse.status;
  }

  @override
  Future<PermissionStatus> requestLocation() {
    return Permission.locationWhenInUse.request();
  }
}
