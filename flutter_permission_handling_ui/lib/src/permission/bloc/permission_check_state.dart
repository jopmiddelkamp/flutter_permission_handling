import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_check_state.freezed.dart';

@freezed
class PermissionCheckState with _$PermissionCheckState {
  const factory PermissionCheckState.loading() = PermissionCheckStateLoading;
  const factory PermissionCheckState.notGranted() =
      PermissionCheckStateNotGranted;
  const factory PermissionCheckState.granted() = PermissionCheckStateGranted;
}
