// ignore_for_file: unused_element

import 'package:conversation_log/core/common/settings/application/setting_repository.dart';
import 'package:conversation_log/core/common/settings/cubit/setting_cubit.dart';
import 'package:conversation_log/core/common/settings/domain/i_setting_repository.dart';
import 'package:conversation_log/core/common/theme/theme.dart';
import 'package:conversation_log/src/home/data/repos/conversation_repository_implementation.dart';
import 'package:conversation_log/src/home/domain/repos/conversation_repository.dart';
import 'package:conversation_log/src/home/domain/usecases/add_conversation.dart';
import 'package:conversation_log/src/home/domain/usecases/delete_conversation.dart';
import 'package:conversation_log/src/home/domain/usecases/edit_conversation_title.dart';
import 'package:conversation_log/src/home/domain/usecases/get_conversations.dart';
import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl
    ..registerFactory(
      () => ThemeCubit(
        isDarkMode: sl<ISettingRepository>().getDarkModeSetting(),
      )..initialize(sl<ISettingRepository>().getDarkModeSetting()),
    )
    ..registerFactory(
      () => SettingCubit(
        settingRep: sl(),
        themeCubit: sl(),
      )..initialize(),
    )

    // Repositories
    ..registerLazySingleton<ISettingRepository>(SettingRepository.new);

  // Services

// External

  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  await conversationInit();
}

Future<void> __init() async {
  // Blocs
  sl..registerSingletonWithDependencies(
        () => ThemeCubit(
      isDarkMode: sl<ISettingRepository>().getDarkModeSetting(),
    )..initialize(sl<ISettingRepository>().getDarkModeSetting()),
    dependsOn: [ISettingRepository],
  )

  ..registerFactory(
        () => SettingCubit(
      settingRep: sl(),
      themeCubit: sl(),
    )..initialize(),
  )

  // Repositories
  ..registerLazySingleton<ISettingRepository>(SettingRepository.new);

  // Services

  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  await conversationInit();
}


Future<void> conversationInit() async {
  sl
    ..registerFactory(
      () => ConversationBloc(
        getConversations: sl(),
        addConversation: sl(),
        deleteConversation: sl(),
        editConversationTitle: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetConversations(sl()),
    )
    ..registerLazySingleton(
      () => AddConversation(sl()),
    )
    ..registerLazySingleton(
      () => DeleteConversation(sl()),
    )
    ..registerLazySingleton(() => EditConversationTitle(sl()))
    ..registerLazySingleton<ConversationRepository>(
      ConversationRepositoryImplementation.new,
    );
}
