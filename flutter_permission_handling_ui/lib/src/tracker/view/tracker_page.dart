import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../flutter_permission_handling_ui.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({Key? key}) : super(key: key);

  Widget _blocProvider({
    required Widget child,
  }) {
    return BlocProvider(
      create: (_) => TrackerCubit(
        deviceGeolocationRepository: GetIt.instance(),
      )..init(),
      child: child,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return _blocProvider(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tracker'),
        ),
        body: const _Body(),
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
    return BlocBuilder<TrackerCubit, TrackerState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const _LoadingIndicator(),
          loaded: (state) => _TrackingInfo(
            state: state,
          ),
        );
      },
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class _TrackingInfo extends StatelessWidget {
  const _TrackingInfo({
    Key? key,
    required this.state,
  }) : super(key: key);

  final TrackerStateLoaded state;

  @override
  Widget build(
    BuildContext context,
  ) {
    final titleStyle = Theme.of(context).textTheme.headline6!.copyWith(
          fontWeight: FontWeight.bold,
        );
    return Column(
      children: [
        Text(
          'Location',
          style: titleStyle,
        ),
        const SizedBox(height: 4),
        Text(
          '${state.userPosition.latitude}, ${state.userPosition.longitude}',
        ),
        const SizedBox(height: 16),
        Text(
          'Speed',
          style: titleStyle,
        ),
        const SizedBox(height: 4),
        Text(
          '${state.userPosition.speed} m/s',
        ),
      ],
    );
  }
}
