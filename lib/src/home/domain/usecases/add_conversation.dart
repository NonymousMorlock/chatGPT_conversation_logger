import 'package:conversation_log/core/common/usecase/usecases.dart';
import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/domain/entities/conversation.dart';
import 'package:conversation_log/src/home/domain/repos/conversation_repository.dart';

class AddConversation extends UsecaseWithParams<void, Conversation> {
  const AddConversation(this._repository);

  final ConversationRepository _repository;

  @override
  FunctionalFuture<void> call(Conversation params) =>
      _repository.addConversation(params);
}
