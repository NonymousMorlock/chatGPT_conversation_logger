import 'package:conversation_log/core/common/theme/theme.dart';
import 'package:conversation_log/src/home/presentation/app/bloc/conversation_bloc.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:conversation_log/src/home/presentation/components/resizable_text_field.dart';
import 'package:conversation_log/src/home/presentation/components/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  late HomeProvider _provider;

  @override
  void initState() {
    final provider = context.read<HomeProvider>()
      ..setEnterTitle(
        listen: false,
      )
      ..initializeDisposables();
    provider.controller!.addListener(provider.setState);
    context.read<ConversationBloc>().add(const GetConversationsEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _provider = context.read<HomeProvider>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _provider.disposeDisposables();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const ResizableTextField(),
                  if (!provider.enterTitle) ...[
                    const SizedBox(height: 10),
                    const Toolbar(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: provider.sender == Sender.ME
                                ? Colors.blue
                                : themeState.inactiveButtonColour,
                            minimumSize: const Size(70, 41),
                          ),
                          onPressed: () {
                            provider.updateSender(Sender.ME);
                          },
                          child: const Text('Me'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: provider.sender == Sender.CHATBOT
                                ? Colors.blue
                                : themeState.inactiveButtonColour,
                            minimumSize: const Size(70, 41),
                          ),
                          onPressed: () {
                            provider.updateSender(Sender.CHATBOT);
                          },
                          child: const Text('ChatGPT'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
