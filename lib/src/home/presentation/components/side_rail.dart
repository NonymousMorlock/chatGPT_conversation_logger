import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SideRail extends StatelessWidget {
  const SideRail({super.key});

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
                      onTap: () {
                        context
                            .read<HomeProvider>()
                            .viewConversation(conversation);
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
