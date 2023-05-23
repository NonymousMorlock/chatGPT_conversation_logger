import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/domain/entities/user_filled_conversation.dart';

abstract class ConversationRepository {
  FunctionalFuture<List<UserFilledConversation>> getConversations();

  FunctionalFuture<void> addConversation(UserFilledConversation conversation);

  FunctionalFuture<void> deleteConversation(String conversationId);

  FunctionalFuture<void> editConversationTitle({
    required String conversationId,
    required String title,
  });
}
