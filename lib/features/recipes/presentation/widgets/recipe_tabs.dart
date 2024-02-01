import 'package:flutter/material.dart';
import 'package:nutrition_app/core/core.dart';

class RecipeTabsWidget extends StatefulWidget {
  const RecipeTabsWidget({
    super.key,
    this.onChanged,
  });

  final void Function(int)? onChanged;

  @override
  State<RecipeTabsWidget> createState() => _RecipeTabsWidgetState();
}

class _RecipeTabsWidgetState extends State<RecipeTabsWidget> {
  late int _index;

  void _onTabChange(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return TabPickerWidget(
      selectedIndex: _index,
      tabs: const [
        TabData(title: 'Ingredients'),
        TabData(title: 'Health'),
        TabData(title: 'Cautions'),
      ],
      onChanged: (index) {
        _onTabChange(index);
        widget.onChanged?.call(index);
      },
    );
  }
}
