import 'package:conversation_log/src/home/data/models/conversation_model.dart';
import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAB extends StatefulWidget {
  const FAB({super.key});

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends State<FAB> {
  bool extend = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return MouseRegion(
          onEnter: (_) {
            Future.delayed(
              const Duration(milliseconds: 500),
              () {
                if (!mounted) return;
                setState(() => extend = true);
              },
            );
          },
          onExit: (_) {
            Future.delayed(
              const Duration(milliseconds: 500),
              () {
                if (!mounted) return;
                setState(() => extend = false);
              },
            );
          },
          child: extend
              ? FloatingActionButton.extended(
                  onPressed: onPressed,
                  label: Text(
                    (provider.canSaveMessage || provider.isEnteringTitle)
                        ? 'Save'
                        : 'New '
                            'Conversation',
                  ),
                  icon: Icon(
                    (provider.canSaveMessage || provider.isEnteringTitle)
                        ? Icons.save
                        : Icons.add,
                  ),
                  elevation: 19,
                )
              : FloatingActionButton(
                  onPressed: onPressed,
                  elevation: 19,
                  child: Icon(
                    (provider.canSaveMessage || provider.isEnteringTitle)
                        ? Icons.save
                        : Icons.add,
                  ),
                ),
        );
      },
    );
  }

  void onPressed() {
    final provider = context.read<HomeProvider>()..exitViewMode();
    if (provider.isEnteringTitle) {
      provider.setTitle(provider.controller!.text.trim());
    } else if (provider.canSaveMessage) {
      final sender = provider.sender == Sender.ME ? 'ME' : 'ChatGPT';
      context.read<ConversationBloc>().add(
            AddConversationEvent(
              ConversationModel.empty().copyWith(
                message: '**$sender:** ${provider.controller!.text.trim()}',
                title: provider.title.trim(),
              ),
            ),
          );
    } else {
      provider.setEnterTitle();
    }
    provider.resetSender();
    provider.controller?.clear();
  }
}
