import 'package:conversation_log/core/utils/functions.dart';
import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SideRail extends StatefulWidget {
  const SideRail({super.key});

  @override
  State<SideRail> createState() => _SideRailState();
}

class _SideRailState extends State<SideRail> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (_, state) {
        return Consumer<HomeProvider>(
          builder: (_, provider, __) {
            return ColoredBox(
              color: Colors.blue,
              child: ListView.builder(
                itemCount: state is ConversationsLoaded
                    ? state.conversations.length
                    : 0,
                itemBuilder: (context, index) {
                  state as ConversationsLoaded;
                  final conversation = state.conversations[index];
                  return ColoredBox(
                    color: provider.currentConversation == conversation
                        ? Colors.blue[900]!
                        : Colors.blue,
                    child: ListTile(
                      minLeadingWidth: 0,
                      minVerticalPadding: 0,
                      leading: const Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 15,
                        color: Colors.white,
                      ),
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
                            if (!mounted) return;
                            context
                                .read<HomeProvider>()
                                .viewConversation(conversation);
                          } else {
                            return;
                          }
                        } else {
                          if (!mounted) return;
                          context
                              .read<HomeProvider>()
                              .viewConversation(conversation);
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
                                      text: 'This will delete the conversation '
                                          'and all its messages.',
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
              ),
            );
          },
        );
      },
    );
  }
}
