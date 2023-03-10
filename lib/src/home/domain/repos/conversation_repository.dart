import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/domain/entities/conversation.dart';

abstract class ConversationRepository {
  FunctionalFuture<List<Conversation>> getConversations();

  FunctionalFuture<void> addConversation(Conversation conversation);

  FunctionalFuture<void> deleteConversation(String conversationId);

  FunctionalFuture<void> editConversationTitle({
    required String conversationId,
    required String title,
  });
}
