import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:conversation_log/src/home/presentation/components/f_a_b.dart';
import 'package:conversation_log/src/home/presentation/components/side_rail.dart';
import 'package:conversation_log/src/home/presentation/views/conversation_view.dart';
import 'package:conversation_log/src/home/presentation/views/log_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          body: Row(
            children: [
              const Expanded(
                flex: 2,
                child: SideRail(),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: provider.viewMode
                      ? const ConversationView()
                      : const LogView(),
                ),
              ),
            ],
          ),
          floatingActionButton: provider.viewMode
              ? const FAB()
              : ((provider.enterTitle && !provider.isEnteringTitle)
                  ? null
                  : const FAB()),
        );
      },
    );
  }
}
