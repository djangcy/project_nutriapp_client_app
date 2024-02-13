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
  Widget _errorView() {
    const String text =
        "It looks like we couldn't find what you were looking for 😢\n"
        'Make sure that your search follows these rules:'
        '\n\t- Your search contains at least one ingredient,'
        '\n\t- Your search is food-related'
        '\n\nExample: What can I make for dinner using chicken?';

    return Expanded(
      child: Flex(
        direction: Axis.vertical,
        children: [
          const Spacer(),
          Expanded(
            child: Padding(
              padding: pagePadding,
              child: Wrap(
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

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

  Widget _loadingView() {
    return const Expanded(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Spacer(),
          CircularProgressIndicator(),
          Spacer(flex: 3),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final queryRecipesState = ref.watch(recipesController);

    return Flex(
      direction: Axis.vertical,
      children: [
        const QuerySearchBarHeader(),
        queryRecipesState.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => _loadingView(),
          success: (success) => _successView(),
          error: (_) => _errorView(),
        ),
      ],
    );
  }
}
