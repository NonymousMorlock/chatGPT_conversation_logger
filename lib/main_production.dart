import 'dart:async';

import 'package:conversation_log/app/app.dart';
import 'package:conversation_log/bootstrap.dart';
import 'package:conversation_log/core/services/injection_container.dart';
import 'package:conversation_log/core/utils/functions.dart';

Future<void> main() async {
  await desktopInit();
  await init();
  unawaited(bootstrap(() => const App()));
}
