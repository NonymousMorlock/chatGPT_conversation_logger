import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conversation_log/src/home/domain/entities/conversation.dart';
import 'package:conversation_log/src/home/domain/usecases/add_conversation.dart';
import 'package:conversation_log/src/home/domain/usecases/delete_conversation.dart';
import 'package:conversation_log/src/home/domain/usecases/get_conversations.dart';
import 'package:equatable/equatable.dart';

part 'conversation_event.dart';

part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc({
    required GetConversations getConversations,
    required AddConversation addConversation,
    required DeleteConversation deleteConversation,
  })  : _getConversations = getConversations,
        _addConversation = addConversation,
        _deleteConversation = deleteConversation,
        super(const ConversationInitial()) {
    on<ConversationEvent>((event, emit) {
      emit(const ConversationLoading());
    });
    on<AddConversationEvent>(_addConversationHandler);
    on<DeleteConversationEvent>(_deleteConversationHandler);
    on<GetConversationsEvent>(_getConversationsHandler);
  }

  final GetConversations _getConversations;
  final AddConversation _addConversation;
  final DeleteConversation _deleteConversation;

  Future<void> _addConversationHandler(
    AddConversationEvent event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _addConversation(event.conversation);
    result.fold(
      (failure) => emit(ConversationError(failure.errorMessage)),
      (_) => add(const GetConversationsEvent()),
    );
  }

  Future<void> _deleteConversationHandler(
    DeleteConversationEvent event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _deleteConversation(event.conversationId);
    result.fold(
      (failure) => emit(ConversationError(failure.errorMessage)),
      (_) => add(const GetConversationsEvent()),
    );
  }

  Future<void> _getConversationsHandler(
    GetConversationsEvent event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _getConversations();
    result.fold(
      (failure) => emit(ConversationError(failure.errorMessage)),
      (conversations) => emit(ConversationsLoaded(conversations)),
    );
  }
}
