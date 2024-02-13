import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/config/config.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/profile/profile.dart';

class LikedRecipeList extends ConsumerStatefulWidget {
  const LikedRecipeList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LikedRecipeListState();
}

class _LikedRecipeListState extends ConsumerState<LikedRecipeList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(likedRecipesController.notifier).getLikedRecipes();
    });

    super.initState();
  }

  Widget _successView() {
    final likedRecipes = ref.watch(likedRecipesProvider);

    if (likedRecipes.isEmpty) {
      return Center(
        child: Text(
          "You haven't liked any recipes yet.",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: likedRecipes.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: RecipeInfoTile.fromRecipe(
              recipe: likedRecipes[index],
              onTap: () => context.pushRoute(
                RecipeDetailRoute(recipeUrl: likedRecipes[index].uri),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final likedRecipesState = ref.watch(likedRecipesController);

    return likedRecipesState.map(
      initial: (_) => const SizedBox.shrink(),
      loading: (_) => const Center(child: CircularProgressIndicator()),
      success: (success) => _successView(),
      error: (_) => const ErrorView(),
    );
  }
}
