import 'package:flutter/material.dart';
import 'package:nutrition_app/features/recipes/presentation/presentation.dart';

class RecipeTagsWidget extends StatefulWidget {
  const RecipeTagsWidget({
    super.key,
    required this.values,
    this.startColor,
    this.endColor,
  });

  final List<String> values;
  final Color? startColor;
  final Color? endColor;

  @override
  State<RecipeTagsWidget> createState() => _RecipeTagsWidgetState();
}

class _RecipeTagsWidgetState extends State<RecipeTagsWidget> {
  late Color _startColor = Colors.white;
  late Color _endColor = Colors.white;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _startColor =
            widget.startColor ?? Theme.of(context).colorScheme.primary;
        _endColor = widget.endColor ?? Theme.of(context).colorScheme.surface;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 12,
      children: widget.values
          .asMap()
          .entries
          .map<Widget>(
            (e) => RecipeTagPip(
              text: e.value,
              color: Color.lerp(
                _startColor,
                _endColor,
                e.key / (widget.values.length - 1),
              ),
            ),
          )
          .toList(),
    );
  }
}
