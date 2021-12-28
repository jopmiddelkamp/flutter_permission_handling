import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../flutter_permission_handling_ui.dart';

class PermissionCheck extends StatelessWidget {
  const PermissionCheck({
    Key? key,
    required this.permission,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final Permission permission;

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProviderAndBuilder<PermissionCheckCubit, PermissionCheckState>(
      create: (context) => PermissionCheckCubit(
        permissionDeviceRepository: GetIt.instance(),
        permission: permission,
      )..init(),
      builder: (context, permissionState) {
        return permissionState.when(
          loading: () => const LoadingPlaceholder(),
          notGranted: () => _InitializeCubitOnAppLifeCycleResume(
            child: _Body(
              permission: permission,
            ),
          ),
          granted: () => _InitializeCubitOnAppLifeCycleResume(
            child: child,
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.permission,
  }) : super(key: key);

  final Permission permission;

  String get permissionName {
    if (permission == Permission.locationWhenInUse) {
      return 'Location when in use';
    }
    return 'Unknown permission';
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final cubit = context.read<PermissionCheckCubit>();
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.yellow.shade800,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$permissionName required!',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Please enable the permission in the settings on your phone.',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Open Settings'),
              onPressed: cubit.openAppSettings,
            ),
          ],
        ),
      ),
    );
  }
}

class _InitializeCubitOnAppLifeCycleResume extends StatefulWidget {
  const _InitializeCubitOnAppLifeCycleResume({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<_InitializeCubitOnAppLifeCycleResume> createState() =>
      _InitializeCubitOnAppLifeCycleResumeState();
}

class _InitializeCubitOnAppLifeCycleResumeState
    extends State<_InitializeCubitOnAppLifeCycleResume>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(
    AppLifecycleState state,
  ) {
    final cubit = context.read<PermissionCheckCubit>();
    if (state == AppLifecycleState.resumed) {
      cubit.init();
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return widget.child;
  }
}
