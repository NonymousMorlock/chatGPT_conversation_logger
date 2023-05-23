import 'package:conversation_log/core/common/theme/cubit/theme_cubit.dart';
import 'package:conversation_log/core/utils/functions.dart';
import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:conversation_log/src/home/presentation/widgets/side_rail_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class UserFilledMessages extends StatefulWidget {
  const UserFilledMessages({super.key});

  @override
  State<UserFilledMessages> createState() => _UserFilledMessagesState();
}

class _UserFilledMessagesState extends State<UserFilledMessages> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Consumer<HomeProvider>(
          builder: (_, provider, __) {
            return ListView.builder(
              itemCount: provider.conversations.length,
              itemBuilder: (context, index) {
                final conversations = provider.conversations
                  ..sort(
                    (a, b) => b.modifiedDate.compareTo(a.modifiedDate),
                  );
                final conversation = conversations[index];
                return ColoredBox(
                  color: provider.currentConversation == conversation
                      ? themeState.selectedItemColour
                      : themeState.sideRailColour,
                  child: SideRailTile(
                    title: provider.editTitle == conversation.id
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextField(
                              autofocus: true,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              onTapOutside: (_) {
                                provider.resetEditTitle();
                              },
                              cursorColor: Colors.white,
                              controller: TextEditingController(
                                text: conversation.title,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                // focusedBorder: OutlineInputBorder(
                                //   borderSide: BorderSide(
                                //     color: Colors.white,
                                //   ),
                                // ),
                                hintText: 'Enter title',
                              ),
                              onSubmitted: (val) {
                                if (val.trim() == conversation.title.trim()) {
                                  provider.resetEditTitle();
                                  return;
                                }
                                context.read<ConversationBloc>().add(
                                      EditConversationTitleEvent(
                                        conversationId: conversation.id,
                                        title: val,
                                      ),
                                    );
                                provider.resetEditTitle();
                              },
                            ),
                          )
                        : Text(
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
                    trailing: provider.currentConversation == conversation
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onPressed: () {
                                  context
                                      .read<HomeProvider>()
                                      .setEditTitle(conversation.id);
                                },
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (await showPlatformDialog(
                                    text: 'This will delete the '
                                        'conversation and all its '
                                        'messages.',
                                    positiveButtonTitle: 'Delete',
                                  )) {
                                    if (!mounted) return;
                                    context.read<ConversationBloc>().add(
                                          DeleteConversationEvent(
                                            conversation.id,
                                          ),
                                        );
                                    provider.exitViewMode();
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
