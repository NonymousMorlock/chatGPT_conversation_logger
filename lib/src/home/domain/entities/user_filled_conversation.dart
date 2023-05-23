import 'dart:io';

import 'package:conversation_log/src/home/domain/entities/conversation.dart';
import 'package:equatable/equatable.dart';

class UserFilledConversation extends Equatable implements Conversation {
  const UserFilledConversation({
    required this.id,
    required this.title,
    required this.filePath,
    required this.fileName,
    required this.file,
    required this.createdDate,
    required this.modifiedDate,
    this.message,
  });

  UserFilledConversation.empty()
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
