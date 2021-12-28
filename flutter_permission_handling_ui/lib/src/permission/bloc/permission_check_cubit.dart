import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../flutter_permission_handling_ui.dart';

typedef CheckPermissionCallback = Future<PermissionStatus> Function(
  PermissionDeviceRepository repository,
);

class PermissionCheckCubit extends Cubit<PermissionCheckState> {
  PermissionCheckCubit({
    required PermissionDeviceRepository permissionDeviceRepository,
    required Permission permission,
  })  : _permissionDeviceRepository = permissionDeviceRepository,
        _permission = permission,
        super(const PermissionCheckState.loading());

  final PermissionDeviceRepository _permissionDeviceRepository;
  final Permission _permission;

  Future<void> init() async {
    final status = await _permissionDeviceRepository.getStatus(
      permission: _permission,
    );
    if (!status.isGranted) {
      final requestResult = await _permissionDeviceRepository.request(
        permission: _permission,
      );
      if (!requestResult.isGranted) {
        emit(const PermissionCheckState.notGranted());
        return;
      }
    }
    emit(const PermissionCheckState.granted());
  }

  // NOT SURE ABOUT THIS
  Future<void> openAppSettings() {
    return _permissionDeviceRepository.openAppSettings();
  }
}
