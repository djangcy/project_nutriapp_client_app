import 'package:flutter/material.dart';

class NavigationHeader extends StatelessWidget {
  const NavigationHeader({
    super.key,
    required this.text,
    this.trailing = const Icon(Icons.chevron_right),
    this.onTap,
  });

  const NavigationHeader.title({
    super.key,
    required this.text,
    this.onTap,
  }) : trailing = const SizedBox.shrink();

  final String text;
  final Widget trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          trailing,
        ],
      ),
    );
  }
}
