import 'package:conversation_log/core/common/usecase/usecases.dart';
import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/domain/entities/user_filled_conversation.dart';
import 'package:conversation_log/src/home/domain/repos/conversation_repository.dart';

class GetConversations extends UsecaseWithoutParams<List<UserFilledConversation>> {
  const GetConversations(this._repository);

  final ConversationRepository _repository;

  @override
  FunctionalFuture<List<UserFilledConversation>> call() => _repository.getConversations();
}
