import 'package:flutter/material.dart';
import 'package:nutrition_app/core/widgets/widgets.dart';

class RecipeGridView extends StatelessWidget {
  const RecipeGridView({
    super.key,
    this.spacing = 0,
    this.children = const [],
  });

  final double spacing;
  final List<RecipeInfoBlock> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: spacing,
      runSpacing: 12,
      children: children,
    );
  }
}
