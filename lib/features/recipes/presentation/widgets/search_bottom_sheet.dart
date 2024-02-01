import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/core/widgets/widgets.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

class SearchBottomSheet extends ConsumerStatefulWidget {
  const SearchBottomSheet._({
    super.key,
  });

  SearchBottomSheet.show(
    BuildContext context, {
    super.key,
  }) {
    showModalBottomSheet<Widget>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => SearchBottomSheet._(key: key),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchBottomSheetState();
}

class _SearchBottomSheetState extends ConsumerState<SearchBottomSheet> {
  Widget _successView() {
    final recipeList = ref.watch(queryRecipesProvider);
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: pagePadding,
        child: ListView(
          children: [
            SizedBox(height: pagePadding.left),
            RecipeGridView(
              children: recipeList.results
                  .map(
                    (e) => RecipeInfoBlock.fromRecipe(recipe: e),
                  )
                  .toList(),
            ),
            SizedBox(height: pagePadding.left),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final queryRecipesState = ref.watch(queryRecipesController);

    return Flex(
      direction: Axis.vertical,
      children: [
        const QuerySearchBarHeader(),
        queryRecipesState.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (success) => _successView(),
          error: (_) => const ErrorView(),
        ),
      ],
    );
  }
}
