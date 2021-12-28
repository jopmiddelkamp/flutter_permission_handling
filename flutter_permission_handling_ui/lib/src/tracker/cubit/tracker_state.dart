import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'tracker_state.freezed.dart';

@freezed
class TrackerState with _$TrackerState {
  const factory TrackerState.loading() = TrackerStateLoading;
  const factory TrackerState.loaded({
    required Position userPosition,
  }) = TrackerStateLoaded;
}
