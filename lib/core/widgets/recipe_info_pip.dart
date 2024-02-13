import 'package:flutter/material.dart';

class RecipeInfoPip extends StatelessWidget {
  const RecipeInfoPip({
    super.key,
    required this.text,
    this.color,
  })  : _height = 25,
        _width = 80,
        _fontSize = 12;

  const RecipeInfoPip.large({
    super.key,
    required this.text,
    this.color,
  })  : _height = 40,
        _width = 100,
        _fontSize = 12;

  const RecipeInfoPip.small({
    super.key,
    required this.text,
    this.color,
  })  : _height = 15,
        _width = 40,
        _fontSize = 8;

  final String text;
  final Color? color;

  final double _height;
  final double _width;
  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    final Color color = this.color ?? Theme.of(context).colorScheme.background;

    return Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: _fontSize,
                ),
          ),
        ],
      ),
    );
  }
}
