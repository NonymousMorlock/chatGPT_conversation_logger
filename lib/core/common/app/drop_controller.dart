import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/foundation.dart';

class DropController extends ChangeNotifier {
  bool _isDragging = false;

  bool get isDragging => _isDragging;

  void dragging() {
    _isDragging = true;
    notifyListeners();
  }

  void notDragging() {
    _isDragging = false;
    notifyListeners();
  }

  File? dropConversations(DropDoneDetails details) {
    final file = File(details.files.first.path);
    if (file.path.split('.').last != 'json') return null;
    return file;
  }
}
