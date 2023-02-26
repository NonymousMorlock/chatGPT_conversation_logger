import 'package:conversation_log/core/common/usecase/usecases.dart';
import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/domain/entities/conversation.dart';
import 'package:conversation_log/src/home/domain/repos/conversation_repository.dart';

class GetConversations extends UsecaseWithoutParams<List<Conversation>> {
  const GetConversations(this._repository);

  final ConversationRepository _repository;

  @override
  FunctionalFuture<List<Conversation>> call() => _repository.getConversations();
}
