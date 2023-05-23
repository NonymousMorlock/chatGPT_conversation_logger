import 'package:conversation_log/src/home/domain/entities/user_filled_conversation.dart';
import 'package:conversation_log/src/home/domain/repos/conversation_repository.dart';
import 'package:conversation_log/src/home/domain/usecases/get_conversations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConversationRepo extends Mock implements ConversationRepository {}

void main() {
  late MockConversationRepo repo;
  late GetConversations usecase;

  setUp(() {
    repo = MockConversationRepo();
    usecase = GetConversations(repo);
  });

  test(
    'should get [List<Conversation>] from the repository',
    () async {
      when(() => repo.getConversations()).thenAnswer(
        (_) async => const Right([]),
      );

      final result = await usecase();

      expect(result, isA<Right<dynamic, List<UserFilledConversation>>>());

      verify(() => repo.getConversations()).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
