import 'dart:convert';

import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/data/models/conversation_message_model.dart';
import 'package:conversation_log/src/home/domain/entities/exported_conversation.dart';

class ExportedConversationModel extends ExportedConversation {
  const ExportedConversationModel({
    required super.id,
    required super.currentNode,
    required super.title,
    required super.timeCreated,
    required super.lastUpdateTime,
    required super.messages,
  });

  factory ExportedConversationModel.fromJson(String source) =>
      ExportedConversationModel.fromMap(json.decode(source) as DataMap);

  factory ExportedConversationModel.fromMap(DataMap map) {
    var currentNode = map['current_node'] as String?;
    var messages = <DataMap>[];
    if (map['messages'] == null) {
      while (currentNode != null) {
        final node = (map['mapping'] as DataMap)[currentNode] as DataMap;
        final message = node['message'] as DataMap?;
        final content = message?['content'] as DataMap?;
        final contentType = content?['content_type'] as String?;
        final parts = content?['parts'] as List?;
        if (message != null &&
            content != null &&
            contentType == 'text' &&
            parts!.isNotEmpty &&
            (parts[0] as String).isNotEmpty &&
            (message['author'] as DataMap)['role'] != 'system') {
          var author = (message['author'] as DataMap)['role'];
          if (author == 'assistant') {
            author = 'ChatGPT';
          }
          messages.add({...node, 'conversation_id': map['id']});
        }
        currentNode = node['parent'] as String?;
      }
      messages = List.from(messages.reversed);
    }
    return ExportedConversationModel(
      id: map['id'] as String,
      currentNode: map['current_node'] as String,
      title: map['title'] as String,
      timeCreated: DateTime.fromMillisecondsSinceEpoch(
        ((map['create_time'] as num) * 1000).toInt(),
      ),
      lastUpdateTime: DateTime.fromMillisecondsSinceEpoch(
        ((map['update_time'] as num) * 1000).toInt(),
      ),
      messages: map['messages'] != null
          ? List<DataMap>.from(map['messages'] as List)
              .map(MessageModel.fromMap)
              .toList()
          : messages.map(MessageModel.fromMap).toList(),
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'current_node': currentNode,
      'title': title,
      'create_time': timeCreated.millisecondsSinceEpoch / 1000,
      'update_time': lastUpdateTime.millisecondsSinceEpoch / 1000,
      'messages':
          messages.map((message) => (message as MessageModel).toMap()).toList(),
    };
  }

  String toJson() => jsonEncode(toMap());
}
