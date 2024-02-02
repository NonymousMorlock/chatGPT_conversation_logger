import 'package:flutter/material.dart';

class SideRailTile extends StatelessWidget {
  const SideRailTile({
    required this.title,
    required this.titleText,
    required this.onTap,
    super.key,
    this.trailing,
  });

  final Widget title;
  final String titleText;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: titleText,
      child: ListTile(
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        leading: const Icon(
          Icons.chat_bubble_outline_rounded,
          size: 15,
          color: Colors.white,
        ),
        title: title,
        onTap: onTap,
        trailing: trailing,
      ),
    );
  }
}
