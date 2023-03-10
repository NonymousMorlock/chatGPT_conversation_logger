import 'package:conversation_log/src/home/domain/repos/conversation_repository.dart';
import 'package:conversation_log/src/home/domain/usecases/edit_conversation_title.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConversationRepository extends Mock
    implements ConversationRepository {}

void main() {
  late MockConversationRepository repository;
  late EditConversationTitle usecase;

  const tConversationId = 'ConversationID';
  const tTitle = 'Test Title';

  setUp(() {
    repository = MockConversationRepository();
    usecase = EditConversationTitle(repository);
    registerFallbackValue(tTitle);
  });

  test(
    'should call the [ConversationRepository]',
    () async {
      when(
        () => repository.editConversationTitle(
          conversationId: any(named: 'conversationId'),
          title: any(named: 'title'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(
        const EditConversationTitleParams(
          conversationId: tConversationId,
          title: tTitle,
        ),
      );

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(
        () => repository.editConversationTitle(
          conversationId: tConversationId,
          title: tTitle,
        ),
      );
      verifyNoMoreInteractions(repository);
    },
  );
}
