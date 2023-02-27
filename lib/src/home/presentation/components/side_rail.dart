import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
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
                  return Container(
                    color: provider.currentConversation == conversation
                        ? Colors.blue[900]
                        : Colors.blue,
                    child: ListTile(
                      minLeadingWidth: 0,
                      minVerticalPadding: 0,
                      leading: const Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 15,
                        color: Colors.white,
                      ),
                      title: Text(
                        conversation.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () async {
                        if (provider.canSaveMessage) {
                          final result =
                              await FlutterPlatformAlert.showCustomAlert(
                            windowTitle: 'Are you sure?',
                            text: 'You have unsaved messages',
                            positiveButtonTitle: 'Continue',
                            negativeButtonTitle: 'Cancel',
                          );
                          if (result == CustomButton.positiveButton) {
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
