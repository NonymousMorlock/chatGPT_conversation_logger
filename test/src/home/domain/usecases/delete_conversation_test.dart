import 'package:conversation_log/src/home/domain/entities/conversation.dart';
import 'package:conversation_log/src/home/domain/repos/conversation_repository.dart';
import 'package:conversation_log/src/home/domain/usecases/delete_conversation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConversationRepo extends Mock implements ConversationRepository {}

void main() {
  late MockConversationRepo repo;
  late DeleteConversation usecase;

  final tConversation = Conversation.empty();

  setUp(() {
    repo = MockConversationRepo();
    usecase = DeleteConversation(repo);
    registerFallbackValue(tConversation);
  });

  test(
    'should call the [ConversationRepository]',
    () async {
      when(() => repo.deleteConversation(any())).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(tConversation.id);

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => repo.deleteConversation(tConversation.id)).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
