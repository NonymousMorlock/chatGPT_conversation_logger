part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();
}

class GetConversationsEvent extends ConversationEvent {
  const GetConversationsEvent();
  @override
  List<Object> get props => [];
}

class AddConversationEvent extends ConversationEvent {
  const AddConversationEvent(this.conversation);

  final Conversation conversation;

  @override
  List<Object> get props => [conversation];
}

class DeleteConversationEvent extends ConversationEvent {
  const DeleteConversationEvent(this.conversationId);

  final String conversationId;

  @override
  List<Object> get props => [conversationId];
}
