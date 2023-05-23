import 'package:conversation_log/src/home/domain/entities/user_filled_conversation.dart';
import 'package:conversation_log/src/home/domain/repos/conversation_repository.dart';
import 'package:conversation_log/src/home/domain/usecases/add_conversation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConversationRepo extends Mock implements ConversationRepository {}

void main() {
  late MockConversationRepo repo;
  late AddConversation usecase;

  final tConversation = UserFilledConversation.empty();

  setUp(() {
    repo = MockConversationRepo();
    usecase = AddConversation(repo);
    registerFallbackValue(tConversation);
  });

  test(
    'should call the [ConversationRepository]',
    () async {
      when(() => repo.addConversation(any())).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(tConversation);

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => repo.addConversation(tConversation)).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
