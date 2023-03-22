import 'package:conversation_log/core/common/theme/theme.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:provider/provider.dart';

class ConversationView extends StatelessWidget {
  const ConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MarkdownWidget(
              data: provider.currentConversation!.message!,
              config: state is ThemeStateDark ? MarkdownConfig(
                configs: [
                  PConfig(
                    textStyle: MarkdownConfig.darkConfig.p.textStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  MarkdownConfig.darkConfig.a,
                  MarkdownConfig.darkConfig.blockquote,
                  MarkdownConfig.darkConfig.code,
                  MarkdownConfig.darkConfig.h1,
                  MarkdownConfig.darkConfig.h2,
                  MarkdownConfig.darkConfig.h3,
                  MarkdownConfig.darkConfig.h4,
                  MarkdownConfig.darkConfig.h5,
                  MarkdownConfig.darkConfig.h6,
                  MarkdownConfig.darkConfig.hr,
                  MarkdownConfig.darkConfig.img,
                  MarkdownConfig.darkConfig.li,
                  MarkdownConfig.darkConfig.input,
                  MarkdownConfig.darkConfig.pre,
                  MarkdownConfig.darkConfig.table,
                ],
              ) : MarkdownConfig.defaultConfig,
            );
          },
        );
      },
    );
  }
}
