import 'dart:convert';

import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/domain/entities/conversation_message.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.conversationId,
    required super.timeCreated,
    required super.author,
    required super.content,
    required super.completed,
    super.lastUpdateTime,
  });

  MessageModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          conversationId: map['conversation_id'] as String,
          timeCreated: DateTime.fromMillisecondsSinceEpoch(
            (((map['message'] as DataMap)['create_time'] as num) * 1000)
                .toInt(),
          ),
          lastUpdateTime: (map['message'] as DataMap)['update_time'] == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(
                  (((map['message'] as DataMap)['update_time'] as num) * 1000)
                      .toInt(),
                ),
          author: ((map['message'] as DataMap)['author'] as DataMap)['role']
              as String,
          content: List<String>.from(
            ((map['message'] as DataMap)['content'] as DataMap)['parts']
                as List<dynamic>,
          )[0],
          completed: ((map['message'] as DataMap)['status'] as String) ==
              'finished_successfully',
        );

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as DataMap);

  MessageModel copyWith({
    String? id,
    String? conversationId,
    DateTime? timeCreated,
    DateTime? lastUpdateTime,
    String? author,
    String? content,
    bool? completed,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      timeCreated: timeCreated ?? this.timeCreated,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      author: author ?? this.author,
      content: content ?? this.content,
      completed: completed ?? this.completed,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'message': {
        'create_time': timeCreated.millisecondsSinceEpoch,
        'update_time': lastUpdateTime?.millisecondsSinceEpoch,
        'author': {'role': author},
        'content': {
          'content_type': 'text',
          'parts': [content],
        },
        'status': completed ? 'finished_successfully' : 'interrupted',
      },
    };
  }

  String toJson() => json.encode(toMap());
}
