import 'package:conversation_log/core/common/theme/cubit/theme_cubit.dart';
import 'package:conversation_log/core/extensions/date_extensions.dart';
import 'package:conversation_log/core/utils/functions.dart';
import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:conversation_log/src/home/presentation/widgets/side_rail_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoggedMessages extends StatefulWidget {
  const LoggedMessages({super.key});

  @override
  State<LoggedMessages> createState() => _LoggedMessagesState();
}

class _LoggedMessagesState extends State<LoggedMessages> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Consumer<HomeProvider>(
          builder: (_, provider, __) {
            return ListView.builder(
              itemCount: provider.exportedConversations.length,
              itemBuilder: (context, index) {
                final conversations = provider.exportedConversations
                  ..sort(
                    (a, b) => b.lastUpdateTime.compareTo(a.lastUpdateTime),
                  );
                final conversation = conversations[index];
                final timeRange = conversation.lastUpdateTime.timeAgo;
                final previousTimeRange = index > 0
                    ? conversations[index - 1].lastUpdateTime.timeAgo
                    : null;
                final showTimeRange = previousTimeRange != timeRange;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showTimeRange)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10)
                            .copyWith(left: 10),
                        child: Text(
                          timeRange,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ColoredBox(
                      color: provider.currentConversation == conversation
                          ? themeState.selectedItemColour
                          : themeState.sideRailColour,
                      child: SideRailTile(
                        title: Text(
                          conversation.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: provider.editTitle != null
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () async {
                          if (provider.canSaveMessage) {
                            if (await showPlatformDialog(
                              text: 'You have unsaved messages',
                            )) {
                              provider
                                ..viewConversation(conversation)

                                ..resetInputs();
                            } else {
                              return;
                            }
                          } else {
                            provider.viewConversation(conversation);
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
