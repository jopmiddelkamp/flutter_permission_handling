import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../flutter_permission_handling_ui.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracker'),
      ),
      body: const PermissionCheck(
        permission: Permission.locationWhenInUse,
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProviderAndBuilder<TrackerCubit, TrackerState>(
      create: (_) => TrackerCubit(
        deviceGeolocationRepository: GetIt.instance(),
      )..init(),
      builder: (context, state) {
        return state.map(
          loading: (_) => const LoadingPlaceholder(),
          loaded: (state) => _TrackingInfo(
            trackerState: state,
          ),
        );
      },
    );
  }
}

class _TrackingInfo extends StatelessWidget {
  const _TrackingInfo({
    Key? key,
    required this.trackerState,
  }) : super(key: key);

  final TrackerStateLoaded trackerState;

  @override
  Widget build(
    BuildContext context,
  ) {
    final titleStyle = Theme.of(context).textTheme.headline6!.copyWith(
          fontWeight: FontWeight.bold,
        );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Location',
            style: titleStyle,
          ),
          const SizedBox(height: 4),
          Text(
            '${trackerState.userPosition.latitude}, ${trackerState.userPosition.longitude}',
          ),
          const SizedBox(height: 16),
          Text(
            'Speed',
            style: titleStyle,
          ),
          const SizedBox(height: 4),
          Text(
            '${trackerState.userPosition.speed} m/s',
          ),
        ],
      ),
    );
  }
}
