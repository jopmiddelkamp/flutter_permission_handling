import 'package:flutter/material.dart';

import '../../../flutter_permission_handling_ui.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return const MaterialApp(
      home: TrackerPage(),
    );
  }
}
