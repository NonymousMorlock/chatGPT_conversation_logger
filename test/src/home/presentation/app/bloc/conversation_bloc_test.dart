import 'package:bloc_test/bloc_test.dart';
import 'package:conversation_log/core/common/errors/failures.dart';
import 'package:conversation_log/src/home/data/models/conversation_model.dart';
import 'package:conversation_log/src/home/domain/usecases/add_conversation.dart';
import 'package:conversation_log/src/home/domain/usecases/delete_conversation.dart';
import 'package:conversation_log/src/home/domain/usecases/get_conversations.dart';
import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetConversations extends Mock implements GetConversations {}

class MockAddConversation extends Mock implements AddConversation {}

class MockDeleteConversation extends Mock implements DeleteConversation {}

void main() {
  late MockGetConversations getConversations;
  late MockAddConversation addConversation;
  late MockDeleteConversation deleteConversation;
  late ConversationBloc bloc;

  final tConversation = ConversationModel.empty();

  setUp(() {
    getConversations = MockGetConversations();
    addConversation = MockAddConversation();
    deleteConversation = MockDeleteConversation();
    bloc = ConversationBloc(
      getConversations: getConversations,
      addConversation: addConversation,
      deleteConversation: deleteConversation,
    );
  });

  test(
    'initial state is ConversationInitial',
    () async {
      expect(bloc.state, equals(const ConversationInitial()));
    },
  );

  group('GetConversationsEvent', () {
    blocTest<ConversationBloc, ConversationState>(
      'emits [ConversationLoading, ConversationLoaded] when '
      'GetConversationsEvent is added',
      build: () {
        when(() => getConversations())
            .thenAnswer((_) async => Right([tConversation]));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetConversationsEvent()),
      expect: () => <ConversationState>[
        const ConversationLoading(),
        ConversationsLoaded([tConversation]),
      ],
      verify: (_) {
        verify(() => getConversations()).called(1);
      },
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits [ConversationLoading, ConversationError] when '
      'GetConversationsEvent is added and usecase fails',
      build: () {
        when(() => getConversations()).thenAnswer(
          (_) async => const Left(
            ServerFailure(message: 'Server Failure', statusCode: 0),
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetConversationsEvent()),
      expect: () => <ConversationState>[
        const ConversationLoading(),
        const ConversationError('0 Error: Server Failure'),
      ],
      verify: (_) {
        verify(() => getConversations()).called(1);
      },
    );
  });

  group('AddConversationEvent', () {
    blocTest<ConversationBloc, ConversationState>(
      'emits [ConversationLoading, ConversationLoaded] when '
      'AddConversationEvent is added',
      build: () {
        when(() => addConversation(tConversation))
            .thenAnswer((_) async => const Right(null));
        when(() => getConversations())
            .thenAnswer((_) async => Right([tConversation]));
        return bloc;
      },
      act: (bloc) => bloc.add(AddConversationEvent(tConversation)),
      expect: () => <ConversationState>[
        const ConversationLoading(),
        ConversationsLoaded([tConversation]),
      ],
      verify: (_) {
        verify(() => addConversation(tConversation)).called(1);
        verify(() => getConversations()).called(1);
      },
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits [ConversationLoading, ConversationError] when '
      'AddConversationEvent is added and usecase fails',
      build: () {
        when(() => addConversation(tConversation)).thenAnswer(
          (_) async => const Left(
            ServerFailure(message: 'Server Failure', statusCode: 0),
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(AddConversationEvent(tConversation)),
      expect: () => <ConversationState>[
        const ConversationLoading(),
        const ConversationError('0 Error: Server Failure'),
      ],
      verify: (_) {
        verify(() => addConversation(tConversation)).called(1);
      },
    );
  });

  group('DeleteConversationEvent', () {
    blocTest<ConversationBloc, ConversationState>(
      'emits [ConversationLoading, ConversationLoaded] when '
      'DeleteConversationEvent is added',
      build: () {
        when(() => deleteConversation(tConversation.id))
            .thenAnswer((_) async => const Right(null));
        when(() => getConversations())
            .thenAnswer((_) async => Right([tConversation]));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteConversationEvent(tConversation.id)),
      expect: () => <ConversationState>[
        const ConversationLoading(),
        ConversationsLoaded([tConversation]),
      ],
      verify: (_) {
        verify(() => deleteConversation(tConversation.id)).called(1);
        verify(() => getConversations()).called(1);
      },
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits [ConversationLoading, ConversationError] when '
      'DeleteConversationEvent is added and usecase fails',
      build: () {
        when(() => deleteConversation(tConversation.id)).thenAnswer(
          (_) async => const Left(
            ServerFailure(message: 'Server Failure', statusCode: 0),
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteConversationEvent(tConversation.id)),
      expect: () => <ConversationState>[
        const ConversationLoading(),
        const ConversationError('0 Error: Server Failure'),
      ],
      verify: (_) {
        verify(() => deleteConversation(tConversation.id)).called(1);
      },
    );
  });
}
