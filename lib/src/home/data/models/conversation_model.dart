import 'dart:convert';
import 'dart:io';

import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  const ConversationModel({
    required super.id,
    required super.title,
    required super.filePath,
    required super.fileName,
    required super.file,
    required super.createdDate,
    required super.modifiedDate,
    super.message,
  });

  ConversationModel.empty()
      : super(
          id: '',
          title: '',
          filePath: '',
          fileName: '',
          file: File(''),
          createdDate: DateTime.now(),
          modifiedDate: DateTime.now(),
        );

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(jsonDecode(source) as DataMap);

  ConversationModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          title: map['title'] as String,
          filePath: map['filePath'] as String,
          fileName: map['fileName'] as String,
          file: File(''),
          createdDate: DateTime.parse(map['createdDate'] as String),
          modifiedDate: DateTime.parse(map['modifiedDate'] as String),
        );

  ConversationModel copyWith({
    String? id,
    String? title,
    String? filePath,
    String? fileName,
    File? file,
    DateTime? createdDate,
    DateTime? modifiedDate,
    String? message,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      file: file ?? this.file,
      createdDate: createdDate ?? this.createdDate,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      message: message ?? this.message,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'title': title,
      'filePath': filePath,
      'fileName': fileName,
      'createdDate': createdDate.toIso8601String(),
      'modifiedDate': modifiedDate.toIso8601String(),
    };
  }

  String toJson() => jsonEncode(toMap());
}
