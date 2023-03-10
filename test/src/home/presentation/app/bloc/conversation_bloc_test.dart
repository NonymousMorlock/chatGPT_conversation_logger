import 'package:bloc_test/bloc_test.dart';
import 'package:conversation_log/core/common/errors/failures.dart';
import 'package:conversation_log/src/home/data/models/conversation_model.dart';
import 'package:conversation_log/src/home/domain/usecases/add_conversation.dart';
import 'package:conversation_log/src/home/domain/usecases/delete_conversation.dart';
import 'package:conversation_log/src/home/domain/usecases/edit_conversation_title.dart';
import 'package:conversation_log/src/home/domain/usecases/get_conversations.dart';
import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetConversations extends Mock implements GetConversations {}

class MockAddConversation extends Mock implements AddConversation {}

class MockDeleteConversation extends Mock implements DeleteConversation {}

class MockEditConversationTitle extends Mock implements EditConversationTitle {}

void main() {
  late MockGetConversations getConversations;
  late MockAddConversation addConversation;
  late MockDeleteConversation deleteConversation;
  late MockEditConversationTitle editConversationTitle;
  late ConversationBloc bloc;

  final tConversation = ConversationModel.empty();

  final tEditConversationTitleParams = EditConversationTitleParams(
    conversationId: tConversation.id,
    title: 'new title',
  );

  setUp(() {
    getConversations = MockGetConversations();
    addConversation = MockAddConversation();
    deleteConversation = MockDeleteConversation();
    editConversationTitle = MockEditConversationTitle();
    bloc = ConversationBloc(
      getConversations: getConversations,
      addConversation: addConversation,
      deleteConversation: deleteConversation,
      editConversationTitle: editConversationTitle,
    );
    registerFallbackValue(tEditConversationTitleParams);
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

  group('EditConversationTitleEvent', () {
    blocTest<ConversationBloc, ConversationState>(
      'emits [ConversationLoading, ConversationLoaded] when '
      'EditConversationTitleEvent is added',
      build: () {
        when(() => editConversationTitle(any()))
            .thenAnswer((_) async => const Right(null));
        when(() => getConversations())
            .thenAnswer((_) async => Right([tConversation]));
        return bloc;
      },
      act: (bloc) => bloc.add(
        EditConversationTitleEvent(
          conversationId: tEditConversationTitleParams.conversationId,
          title: tEditConversationTitleParams.title,
        ),
      ),
      expect: () => <ConversationState>[
        const ConversationLoading(),
        ConversationsLoaded([tConversation]),
      ],
      verify: (_) {
        verify(() => editConversationTitle(tEditConversationTitleParams))
            .called(1);
        verify(() => getConversations()).called(1);
      },
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits [ConversationLoading, ConversationError] when '
      'EditConversationTitleEvent is added and usecase fails',
      build: () {
        when(() => editConversationTitle(any())).thenAnswer(
          (_) async => const Left(
            ServerFailure(message: 'Server Failure', statusCode: 0),
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        EditConversationTitleEvent(
          conversationId: tEditConversationTitleParams.conversationId,
          title: tEditConversationTitleParams.title,
        ),
      ),
      expect: () => <ConversationState>[
        const ConversationLoading(),
        const ConversationError('0 Error: Server Failure'),
      ],
      verify: (_) {
        verify(() => editConversationTitle(tEditConversationTitleParams))
            .called(1);
      },
    );
  });
}
