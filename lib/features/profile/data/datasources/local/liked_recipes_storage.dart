import 'dart:convert';

import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

class LikedRecipesStorage {
  const LikedRecipesStorage(this.storage);

  final StorageService storage;

  String get _likedRecipesKey => 'liked_recipes_storage_liked_recipes';

  Future<List<RecipeModel>> getLikedRecipes() async {
    final dynamic recipes = storage.get(_likedRecipesKey);

    if (recipes is List) {
      return recipes.map((e) {
        final jsonString = json.encode(e);
        final decode = json.decode(jsonString) as Map<String, dynamic>;

        return RecipeModel.fromJson(decode);
      }).toList();
    }

    Logger.warning('Failed to decode liked recipes: ${StackTrace.current}');

    return [];
  }

  Future<void> addLikedRecipe(RecipeModel likedRecipe) async {
    final existingValues = storage.get(_likedRecipesKey);

    if (existingValues is List<dynamic>) {
      await storage.set(_likedRecipesKey, [
        ...existingValues,
        likedRecipe.toJson(),
      ]);
    } else if (existingValues == null) {
      await storage.set(_likedRecipesKey, [
        likedRecipe.toJson(),
      ]);
    }
  }

  Future<void> removeLikedRecipe(String likedRecipeUri) async {
    final existingValues = await getLikedRecipes();

    existingValues.removeWhere((e) => e.uri == likedRecipeUri);

    await storage.set(
      _likedRecipesKey,
      existingValues.map((e) => e.toJson()).toList(),
    );
  }
}
