import 'package:conversation_log/core/common/theme/cubit/theme_cubit.dart';
import 'package:conversation_log/src/home/presentation/widgets/code_block_wrapper.dart';
import 'package:conversation_log/src/home/presentation/widgets/markdown_custom/custom_text_node.dart';
import 'package:conversation_log/src/home/presentation/widgets/markdown_custom/latex_syntax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_widget/markdown_widget.dart';

class MarkdownRenderer extends StatefulWidget {
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
  State<MarkdownRenderer> createState() => _MarkdownRendererState();
}

class _MarkdownRendererState extends State<MarkdownRenderer> {
  final TocController controller = TocController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state is DarkTheme;
        final config =
            isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;
        CodeBlockWrapper codeWrapper(
          Widget child,
          String text,
          String language,
        ) {
          return CodeBlockWrapper(child, text, language);
        }

        final theme = Theme.of(context);
        return Theme(
          data: theme.copyWith(
            textTheme: theme.textTheme.copyWith(
              titleLarge: theme.textTheme.titleLarge?.copyWith(
                color: state.primaryTextColor,
              ),
            ),
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: state.primaryTextColor),
            child: MarkdownWidget(
              data: widget.data,
              physics: widget.physics,
              shrinkWrap: widget.shrinkWrap,
              config: config.copy(
                configs: [
                  if (isDark)
                    PreConfig.darkConfig.copy(wrapper: codeWrapper)
                  else
                    const PreConfig().copy(wrapper: codeWrapper),
                ],
              ),
              tocController: controller,
              markdownGenerator: MarkdownGenerator(
                generators: [latexGenerator],
                inlineSyntaxList: [LatexSyntax()],
                textGenerator: (node, config, visitor) {
                  return CustomTextNode(node.textContent, config, visitor);
                },
                richTextBuilder: (span) => Text.rich(
                  span,
                  textScaler: TextScaler.noScaling,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
