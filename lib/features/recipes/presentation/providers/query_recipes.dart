import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

final queryRecipesProvider =
    StateProvider<PaginatedResponse<RecipeModel>>((ref) {
  return const PaginatedResponse(page: 0, results: <RecipeModel>[]);
});
