import 'dart:io';

import 'package:file_picker/file_picker.dart';

class GeneralUtils {
  /// Picks a .json file from the device's storage and returns its contents as
  /// a [String].
  static Future<File?> pickJsonFile() async {
    final filePicker = FilePicker.platform;
    final result = await filePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      return file;
    }
    return null;
  }
}
