import 'dart:convert';
import 'dart:io';

import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/data/models/conversation_model.dart';
import 'package:conversation_log/src/home/domain/entities/conversation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tConversationModel = ConversationModel.empty().copyWith(
    createdDate: DateTime.parse('2023-02-25T16:57:07.386'),
    modifiedDate: DateTime.parse('2023-02-25T16:57:07.386'),
  );

  test(
    'should be a subclass of [Conversation] entity',
        () async {
      expect(tConversationModel, isA<Conversation>());
    },
  );

  group('fromJson', () {
    test(
      'should return [ConversationModel] with the right data',
          () async {
            final json = fixture('conversation.json');
            final result = ConversationModel.fromJson(json);

            expect(result, equals(tConversationModel));
      },
    );
  });

  group('fromMap', () {
    test(
      'should return [ConversationModel] with the right data',
      () async {
        final jsonMap = jsonDecode(fixture('conversation.json')) as DataMap;
        final conversationMap = {'file': File(''), ...jsonMap};
        final result = ConversationModel.fromMap(conversationMap);

        expect(result, equals(tConversationModel));
      },
    );
  });

  group('copyWith', () {
    test(
      'should return a mutated version of tConversationModel',
          () async {
       final result = tConversationModel.copyWith(id: 'id');
       expect(result.id, 'id');
      },
    );
  });

  group('toMap', () {
    test(
      'should return a Map with the correct data',
      () async {
        final tMap = {
          'id': tConversationModel.id,
          'title': tConversationModel.title,
          'filePath': tConversationModel.filePath,
          'fileName': tConversationModel.fileName,
          'createdDate': tConversationModel.createdDate.toIso8601String(),
          'modifiedDate': tConversationModel.modifiedDate.toIso8601String(),
        };
        final result = tConversationModel.toMap();
        expect(result, equals(tMap));
      },
    );
  });
  
  group('toJson', () {
    test(
      'should return JSON String with the right data',
          () async {
            final tMap = {
              'id': tConversationModel.id,
              'title': tConversationModel.title,
              'filePath': tConversationModel.filePath,
              'fileName': tConversationModel.fileName,
              'createdDate': tConversationModel.createdDate.toIso8601String(),
              'modifiedDate': tConversationModel.modifiedDate.toIso8601String(),
            };
            final result = tConversationModel.toJson();
            expect(result, equals(jsonEncode(tMap)));
      },
    );
  });
}
