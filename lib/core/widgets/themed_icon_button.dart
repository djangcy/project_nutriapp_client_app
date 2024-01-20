import 'package:flutter/material.dart';

enum _ButtonStyle {
  fill,
  background,
  onBackground,
}

class ThemedIconButton extends StatelessWidget {
  const ThemedIconButton.onBackground({
    super.key,
    required this.iconData,
    this.size = 18,
    this.onTap,
  }) : _buttonStyle = _ButtonStyle.onBackground;

  const ThemedIconButton.background({
    super.key,
    required this.iconData,
    this.size = 18,
    this.onTap,
  }) : _buttonStyle = _ButtonStyle.background;

  const ThemedIconButton.fill({
    super.key,
    required this.iconData,
    this.size = 18,
    this.onTap,
  }) : _buttonStyle = _ButtonStyle.fill;

  final _ButtonStyle _buttonStyle;

  final IconData iconData;
  final double size;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool outlined = false;
    Color color = Theme.of(context).colorScheme.background;
    final Color outlinedColor = Theme.of(context).colorScheme.onBackground;

    switch (_buttonStyle) {
      case _ButtonStyle.fill:
        outlined = true;
        color = Theme.of(context).colorScheme.background;
      case _ButtonStyle.background:
        outlined = false;
        color = Theme.of(context).colorScheme.background;
      case _ButtonStyle.onBackground:
        outlined = false;
        color = Theme.of(context).colorScheme.onBackground;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: !outlined
            ? null
            : BoxDecoration(
                shape: BoxShape.circle,
                color: outlinedColor.withOpacity(0.6),
              ),
        child: Icon(
          iconData,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
