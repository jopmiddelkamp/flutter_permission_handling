import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_permission_handling_ui/src/shared/repositories/geolocation_device_repository.dart';
import 'package:flutter_permission_handling_ui/src/shared/repositories/permission_device_repository.dart';
import 'package:get_it/get_it.dart';

import '../flutter_permission_handling_ui.dart';

Future<void> boot() async {
  await registerDependencies();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async => await BlocOverrides.runZoned(
      () async => runApp(const App()),
      // blocObserver: CustomBlocObserver(),
    ),
    (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
    },
  );
}

Future<void> registerDependencies() async {
  GetIt.instance.registerSingleton<GeolocationDeviceRepository>(
    GeolocationDeviceRepositoryImpl(),
  );
  GetIt.instance.registerSingleton<PermissionDeviceRepository>(
    PermissionDeviceRepositoryImpl(),
  );
  await GetIt.instance.allReady();
}
