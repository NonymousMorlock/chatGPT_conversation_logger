import 'package:conversation_log/core/common/settings/cubit/setting_cubit.dart';
import 'package:conversation_log/core/common/settings/domain/i_setting_repository.dart';
import 'package:conversation_log/core/common/theme/cubit/theme_cubit.dart';
import 'package:conversation_log/core/services/injection_container.dart';
import 'package:conversation_log/core/services/router.dart';
import 'package:conversation_log/core/utils/constants.dart';
import 'package:conversation_log/l10n/l10n.dart';
import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => sl<ISettingRepository>(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => HomeProvider(sl<SharedPreferences>()),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<ThemeCubit>()),
            BlocProvider(create: (_) => sl<SettingCubit>()),
            BlocProvider(create: (_) => sl<ConversationBloc>()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, theme) {
              return MaterialApp(
                navigatorKey: kNavigatorKey,
                theme: ThemeData(
                  scaffoldBackgroundColor: theme.backgroundColor,
                  appBarTheme: AppBarTheme(color: theme.appBarColor),
                  colorScheme: ColorScheme.fromSwatch(
                    accentColor: theme.accentColor,
                    primarySwatch: theme.primarySwatch,
                    backgroundColor: theme.backgroundColor,
                  ),
                ),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                onGenerateRoute: generateRoute,
              );
            },
          ),
        ),
      ),
    );
  }
}
