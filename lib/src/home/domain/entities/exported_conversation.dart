import 'package:conversation_log/src/home/domain/entities/conversation.dart';
import 'package:conversation_log/src/home/domain/entities/conversation_message.dart';
import 'package:equatable/equatable.dart';

class ExportedConversation extends Equatable implements Conversation {
  const ExportedConversation({
    required this.id,
    required this.currentNode,
    required this.title,
    required this.timeCreated,
    required this.lastUpdateTime,
    required this.messages,
  });

  final String id;
  final String currentNode;
  final String title;
  final DateTime timeCreated;
  final DateTime lastUpdateTime;
  final List<Message> messages;

  @override
  List<Object?> get props => [id];
}
