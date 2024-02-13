import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/features/recipes/data/models/recipe.dart';

final likedRecipesProvider =
    StateProvider<List<RecipeModel>>((ref) {
  return const [];
});
