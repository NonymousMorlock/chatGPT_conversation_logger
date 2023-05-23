import 'package:conversation_log/core/common/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/blocks/leaf/paragraph.dart';
import 'package:markdown_widget/widget/markdown.dart';

class MarkdownRenderer extends StatelessWidget {
  const MarkdownRenderer(
    this.data, {
    super.key,
    this.physics,
    this.shrinkWrap = false,
  });

  final String data;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MarkdownWidget(
          data: data,
          physics: physics,
          shrinkWrap: shrinkWrap,
          config: state is ThemeStateDark
              ? MarkdownConfig(
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
                )
              : MarkdownConfig.defaultConfig,
        );
      },
    );
  }
}
