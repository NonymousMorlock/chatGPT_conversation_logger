import 'package:conversation_log/src/home/domain/entities/user_filled_conversation.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:conversation_log/src/home/presentation/views/exported_conversation_view.dart';
import 'package:conversation_log/src/home/presentation/views/user_filled_conversation_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_highlight_text/search_highlight_text.dart';

class ConversationView extends StatelessWidget {
  const ConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return SearchTextInheritedWidget(
          searchText: provider.searchController.text,
          child: Builder(
            builder: (_) {
              return provider.currentConversation! is UserFilledConversation
                  ? const UserFilledConversationView()
                  : const ExportedConversationView();
            },
          ),
        );
      },
    );
  }
}
