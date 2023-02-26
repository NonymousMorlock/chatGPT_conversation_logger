import 'package:conversation_log/core/common/usecase/usecases.dart';
import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/domain/repos/conversation_repository.dart';

class DeleteConversation extends UsecaseWithParams<void, String> {
  const DeleteConversation(this._repository);

  final ConversationRepository _repository;

  @override
  FunctionalFuture<void> call(String params) =>
      _repository.deleteConversation(params);
}
