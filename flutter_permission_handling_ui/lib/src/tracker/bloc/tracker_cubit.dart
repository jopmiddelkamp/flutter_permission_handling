import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../flutter_permission_handling_ui.dart';

class TrackerCubit extends Cubit<TrackerState> {
  TrackerCubit({
    required GeolocationDeviceRepository deviceGeolocationRepository,
  })  : _deviceGeolocationRepository = deviceGeolocationRepository,
        super(const TrackerState.loading());

  final GeolocationDeviceRepository _deviceGeolocationRepository;

  late StreamSubscription _streamSub;

  void init() {
    _streamSub =
        _deviceGeolocationRepository.streamPosition().listen((position) {
      emit(TrackerState.loaded(
        userPosition: position,
      ));
    });
  }

  @override
  Future<void> close() {
    _streamSub.cancel();
    return super.close();
  }
}
