import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:markdown_toolbar/markdown_toolbar.dart';
import 'package:provider/provider.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MarkdownToolbar(
              useIncludedTextField: false,
              controller: provider.controller,
              focusNode: provider.focus,
            ),
            const SizedBox(width: 5),
            Tooltip(
              message: 'Reset Size',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  minimumSize: const Size(70, 50),
                ),
                onPressed: provider.resetFieldSize,
                child: const Icon(
                  Icons.undo_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
