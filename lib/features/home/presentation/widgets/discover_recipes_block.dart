import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/config/config.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

class DiscoverRecipesBlock extends ConsumerStatefulWidget {
  const DiscoverRecipesBlock({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DiscoverRecipesBlockState();
}

class _DiscoverRecipesBlockState extends ConsumerState<DiscoverRecipesBlock> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchRecipesController.notifier).searchRecipes(
            query: 'discover',
          );
    });
  }

  Widget _successView() {
    final recipes = ref.watch(searchRecipesProvider);
    final recipeList = recipes.results.take(5);

    return Column(
      children: [
        const NavigationHeader(
          text: 'Discover Recipes', // TODO: Get from l10n
        ),
        SizedBox(
          width: double.infinity,
          child: RecipeGridView(
            children: recipeList
                .map(
                  (e) => RecipeInfoBlock.fromRecipe(
                    recipe: e,
                    onTap: () => context.pushRoute(
                      RecipeDetailRoute(recipeUrl: e.uri),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchRecipesState = ref.watch(searchRecipesController);

    return searchRecipesState.map(
      initial: (_) => const SizedBox.shrink(),
      loading: (_) => const SizedBox.shrink(),
      success: (success) => _successView(),
      error: (_) => const SizedBox.shrink(),
    );
  }
}
