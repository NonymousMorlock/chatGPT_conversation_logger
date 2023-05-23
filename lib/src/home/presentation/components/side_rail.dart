import 'package:conversation_log/core/common/theme/theme.dart';
import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:conversation_log/src/home/presentation/widgets/logged_messages.dart';
import 'package:conversation_log/src/home/presentation/widgets/user_filled_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SideRail extends StatefulWidget {
  const SideRail({super.key});

  @override
  State<SideRail> createState() => _SideRailState();
}

class _SideRailState extends State<SideRail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return BlocConsumer<ConversationBloc, ConversationState>(
          listener: (_, state) {
            if (state is ConversationsLoaded) {
              provider.conversations = state.conversations;
            }
          },
          builder: (_, state) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                return ColoredBox(
                  color: themeState.sideRailColour,
                  child: provider.initializing
                      ? Center(
                          child: Lottie.asset(themeState.loadingFiles),
                        )
                      : provider.viewType == ViewType.EXPORTED &&
                              provider.exportedConversations.isNotEmpty
                          ? const LoggedMessages()
                          : const UserFilledMessages(),
                );
              },
            );
          },
        );
      },
    );
  }
}
