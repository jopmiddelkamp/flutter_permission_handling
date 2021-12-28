import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

// NOT SURE ABOUT THIS YET - HALF IMPLEMENTED
abstract class PermissionDeviceRepository {
  Future<PermissionStatus> getStatus({
    required Permission permission,
  });
  Future<PermissionStatus> request({
    required Permission permission,
  });
  // NOT SURE ABOUT THIS
  Future<void> openAppSettings();
}

class PermissionDeviceRepositoryImpl implements PermissionDeviceRepository {
  @override
  Future<PermissionStatus> getStatus({
    required Permission permission,
  }) {
    return permission.status;
  }

  @override
  Future<PermissionStatus> request({
    required Permission permission,
  }) {
    return permission.request();
  }

  @override
  Future<void> openAppSettings() {
    // TODO: implement openSettings
    return permission_handler.openAppSettings();
  }
}
