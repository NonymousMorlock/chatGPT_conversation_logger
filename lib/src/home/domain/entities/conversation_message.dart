import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.conversationId,
    required this.timeCreated,
    required this.author,
    required this.content,
    required this.completed,
    this.lastUpdateTime,
  });

  final String id;
  final String conversationId;
  final DateTime timeCreated;
  final DateTime? lastUpdateTime;
  final String author;
  final String content;
  final bool completed;

  @override
  List<Object?> get props => [id, conversationId];
}
