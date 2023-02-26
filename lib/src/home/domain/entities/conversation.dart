import 'dart:io';

import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  const Conversation({
    required this.id,
    required this.title,
    required this.filePath,
    required this.fileName,
    required this.file,
    required this.createdDate,
    required this.modifiedDate,
    this.message,
  });

  Conversation.empty()
      : id = '',
        title = '',
        filePath = '',
        fileName = '',
        file = File(''),
        createdDate = DateTime.now(),
        modifiedDate = DateTime.now(),
        message = null;

  final String id;
  final String title;
  final String filePath;
  final String fileName;
  final File file;
  final DateTime createdDate;
  final DateTime modifiedDate;
  final String? message;

  @override
  List<Object?> get props => [
        id,
      ];
}
