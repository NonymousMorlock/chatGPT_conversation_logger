part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();
}

class ConversationInitial extends ConversationState {
  const ConversationInitial();
  @override
  List<Object> get props => [];
}

class ConversationLoading extends ConversationState {
  const ConversationLoading();
  @override
  List<Object> get props => [];
}

class ConversationsLoaded extends ConversationState {
  const ConversationsLoaded(this.conversations);
  final List<Conversation> conversations;
  @override
  List<Object> get props => [conversations];
}

class ConversationError extends ConversationState {
  const ConversationError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
