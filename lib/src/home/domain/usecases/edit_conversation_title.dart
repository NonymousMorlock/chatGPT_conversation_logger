import 'package:conversation_log/core/common/usecase/usecases.dart';
import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/domain/repos/conversation_repository.dart';
import 'package:equatable/equatable.dart';

class EditConversationTitle
    extends UsecaseWithParams<void, EditConversationTitleParams> {
  const EditConversationTitle(this._repository);

  final ConversationRepository _repository;

  @override
  FunctionalFuture<void> call(EditConversationTitleParams params) {
    return _repository.editConversationTitle(
      conversationId: params.conversationId,
      title: params.title,
    );
  }
}

class EditConversationTitleParams extends Equatable {
  const EditConversationTitleParams({
    required this.conversationId,
    required this.title,
  });

  final String conversationId;
  final String title;

  @override
  List<Object?> get props => [
        conversationId,
        title,
      ];
}
