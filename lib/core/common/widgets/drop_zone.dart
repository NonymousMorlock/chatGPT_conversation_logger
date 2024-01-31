import 'package:conversation_log/core/common/app/drop_controller.dart';
import 'package:conversation_log/core/utils/functions.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropZone extends StatelessWidget {
  const DropZone({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<DropController>(
      builder: (_, controller, __) {
        return DropTarget(
          onDragEntered: (_) => controller.dragging(),
          onDragExited: (_) => controller.notDragging(),
          onDragDone: (details) async {
            final file = controller.dropConversations(details);
            if (file != null) {
              final homeProvider = context.read<HomeProvider>();
              final conversationsSet =
                  homeProvider.setConversationsFromFile(file);
              if (conversationsSet) {
                final result = await showPlatformDialog(
                  windowTitle: 'Conversations Loaded',
                  text: 'Do you want to save this conversation?\nThis '
                      'will replace current conversations',
                  positiveButtonTitle: 'Save',
                );
                if (result) {
                  await homeProvider.saveConversations();
                }
              }
            }
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                foregroundDecoration: controller.isDragging
                    ? BoxDecoration(
                        color: const Color(0xFF13B9FF).withOpacity(.2),
                      )
                    : null,
                child: child,
              ),
              if (controller.isDragging)
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cloud_upload,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      'Drop to upload',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
