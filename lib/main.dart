import 'package:flutter_permission_handling_core/flutter_permission_handling_core.dart'
    as core;
import 'package:flutter_permission_handling_ui/flutter_permission_handling_ui.dart'
    as ui;

void main() async {
  await core.bootstrap();
  await ui.boot();
}
