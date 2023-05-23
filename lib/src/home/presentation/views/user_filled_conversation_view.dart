import 'package:conversation_log/core/common/theme/theme.dart';
import 'package:conversation_log/src/home/domain/entities/user_filled_conversation.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:conversation_log/src/home/presentation/widgets/markdown_renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class UserFilledConversationView extends StatelessWidget {
  const UserFilledConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MarkdownRenderer(
              (provider.currentConversation! as UserFilledConversation)
                  .message!,
            );
          },
        );
      },
    );
  }
}
