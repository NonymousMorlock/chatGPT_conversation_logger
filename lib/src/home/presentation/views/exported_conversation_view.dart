import 'package:conversation_log/core/common/theme/theme.dart';
import 'package:conversation_log/src/home/domain/entities/exported_conversation.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:conversation_log/src/home/presentation/widgets/markdown_renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ExportedConversationView extends StatelessWidget {
  const ExportedConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return ListView.builder(
              itemCount: (provider.currentConversation! as ExportedConversation)
                  .messages
                  .length,
              itemBuilder: (_, index) {
                final message =
                    (provider.currentConversation! as ExportedConversation)
                        .messages[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RawChip(
                      backgroundColor: themeState.accentColor,
                      side: const BorderSide(color: Colors.grey),
                      label: Text(
                        message.author == 'user'
                            ? 'ME'
                            : message.author.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    // message content
                    const SizedBox(height: 8),
                    MarkdownRenderer(
                      message.content,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                    const SizedBox(height: 30),
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
