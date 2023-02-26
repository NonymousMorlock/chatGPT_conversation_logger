import 'dart:io';

import 'package:conversation_log/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_window_close/flutter_window_close.dart';
import 'package:window_manager/window_manager.dart';

@Deprecated('Use the flutter_window_close package instead.')
void windowEvent() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.window.onPlatformMessage = (message, _, __) async {
      if (message == 'SystemNavigator.pop') {
        await showDialog<void>(
          context: kNavigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Are you sure you want to exit?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('No'),
                ),
                const TextButton(
                  onPressed: SystemNavigator.pop,
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
      }
    };
  }
}

Future<void> desktopInit() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    windowCloseEvent();
    // await windowManager.ensureInitialized();
    //
    // const windowOptions = WindowOptions(
    //   size: Size(1280, 800),
    //   center: true,
    //   title: 'ChatGPT Conversation Log',
    //   backgroundColor: Colors.transparent,
    //   skipTaskbar: false,
    //   titleBarStyle: TitleBarStyle.normal,
    // );
    //
    // await windowManager.waitUntilReadyToShow(windowOptions, () async {
    //   await windowManager.show();
    //   await windowManager.focus();
    // });
  }
}

void windowCloseEvent() {
  FlutterWindowClose.setWindowShouldCloseHandler(() async {
    final result = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: 'Are you sure?',
      text: 'You will lose all unsaved data.',
      positiveButtonTitle: 'Quit',
      negativeButtonTitle: 'Cancel',
    );
    return result == CustomButton.positiveButton;
  });
}
