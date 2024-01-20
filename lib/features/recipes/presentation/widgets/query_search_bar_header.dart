import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

class QuerySearchBarHeader extends ConsumerStatefulWidget {
  const QuerySearchBarHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchBarHeaderState();
}

class _SearchBarHeaderState extends ConsumerState<QuerySearchBarHeader> {
  late final FocusNode _searchFocusNode;
  late final TextEditingController _textController;

  late bool _showClear;

  Future<void> onSearch(String query) async {
    await ref.read(queryRecipesController.notifier).queryRecipes(query);
  }

  void _onTextControllerChanged() {
    setState(() {
      _showClear = _textController.value.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _showClear = false;
    _searchFocusNode = FocusNode();
    _textController = TextEditingController()
      ..addListener(_onTextControllerChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pagePadding.left),
          child: PrimaryFullSearchBar(
            focusNode: _searchFocusNode,
            controller: _textController,
            leading: InkWell(
              child: const Icon(Icons.arrow_back),
              onTap: () => Navigator.pop(context),
            ),
            trailing: [
              if (_showClear)
                InkWell(
                  child: const Icon(Icons.clear),
                  onTap: () => _textController.clear(),
                ),
            ],
            onSubmitted: onSearch,
          ),
        ),
        const SizedBox(height: 8),
        TabPickerWidget(
          tabs: const [
            TabData(title: 'Dinner'),
            TabData(title: 'Lunch'),
            TabData(title: 'Breakfast'),
            TabData(title: 'Snack'),
          ],
        ),
      ],
    );
  }
}
