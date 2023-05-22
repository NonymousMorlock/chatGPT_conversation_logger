import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:conversation_log/core/common/errors/failures.dart';
import 'package:conversation_log/core/utils/typedefs.dart';
import 'package:conversation_log/src/home/data/models/conversation_model.dart';
import 'package:conversation_log/src/home/domain/entities/conversation.dart';
import 'package:conversation_log/src/home/domain/repos/conversation_repository.dart';
import 'package:dartz/dartz.dart';

class ConversationRepositoryImplementation implements ConversationRepository {
  const ConversationRepositoryImplementation();

  File get jsonFile => File('database/conversations/conversations.json');

  DataMap get jsonData => jsonDecode(jsonFile.readAsStringSync()) as DataMap;

  @override
  FunctionalFuture<List<Conversation>> getConversations() async {
    try {
      final data = DataMap.from(jsonData);
      final files = Directory('database/collection')
          .listSync()
          .whereType<File>()
          .toList();
      final conversations = <Conversation>[];
      for (final file in files) {
        final fileId = file.path.split('/').last.split('.').first;
        final fileData = data[fileId] as DataMap?;
        if (fileData != null) {
          final conversation = ConversationModel.fromMap(fileData).copyWith(
            file: file,
            message: file.readAsStringSync(),
          );
          conversations.add(conversation);
        }
      }
      return Right(conversations);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FunctionalFuture<void> addConversation(Conversation conversation) async {
    assert(conversation is ConversationModel, 'Invalid conversation type');
    try {
      final data = DataMap.from(jsonData);
      final title = conversation.title.trim();
      var id = _generateUniqueId();
      final existingFileData = data.values.whereType<DataMap>().firstWhere(
            (element) =>
                (element['title'] as String).toLowerCase() ==
                title.toLowerCase(),
            orElse: () => {},
          );
      if (existingFileData.isNotEmpty) {
        (data[existingFileData['id']] as DataMap)['modifiedDate'] =
            DateTime.now().toIso8601String();
        id = existingFileData['id'] as String;
      } else {
        data[id] = (conversation as ConversationModel)
            .copyWith(
              id: id,
              filePath: 'database/collection/$id',
              fileName: id,
              createdDate: DateTime.now(),
              modifiedDate: DateTime.now(),
            )
            .toMap();
      }

      await jsonFile.writeAsString(jsonEncode(data));

      final file = File('database/collection/$id.md');
      if (file.existsSync()) {
        await file.writeAsString(
          '${conversation.message}\n\n',
          mode: FileMode.append,
        );
      } else {
        await file.create(recursive: true);
        await file.writeAsString('${conversation.message}\n\n');
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FunctionalFuture<void> deleteConversation(String conversationId) async {
    try {
      final data = DataMap.from(jsonData)..remove(conversationId);

      await jsonFile.writeAsString(jsonEncode(data));

      final file = File('database/collection/$conversationId.md');
      if (file.existsSync()) {
        await file.delete();
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FunctionalFuture<void> editConversationTitle({
    required String conversationId,
    required String title,
  }) async {
    try {
      final data = DataMap.from(jsonData);
      final fileData = data[conversationId] as DataMap?;
      if (fileData != null) {
        (data[conversationId] as DataMap)['title'] = title;
        (data[conversationId] as DataMap)['modifiedDate'] =
            DateTime.now().toIso8601String();
        await jsonFile.writeAsString(jsonEncode(data));
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  String _generateUniqueId() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final rand = Random().nextInt(1000000);
    return '$now$rand';
  }
}
