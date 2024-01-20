import 'package:nutrition_app/features/recipes/recipes.dart';

class RecipeEntity extends RecipeModel {
  RecipeEntity({
    required super.uri,
    required super.label,
    required super.image,
    required super.source,
    required super.recipeUrl,
    required super.servings,
    required super.dietLabels,
    required super.healthLabels,
    required super.cautions,
    required super.ingredientLines,
    required List<IngredientEntity> ingredients,
    required super.calories,
    required super.totalWeight,
    required super.totalTime,
    required super.cuisineType,
    required super.mealType,
    required super.dishType,
    required Map<String, NutrientEntity> totalNutrients,
  }) : super(ingredients: ingredients, totalNutrients: totalNutrients);
}

class NutrientEntity extends Nutrient {
  NutrientEntity({
    required super.label,
    required super.quantity,
    required super.unit,
  });
}

class IngredientEntity extends Ingredient {
  IngredientEntity({
    required super.text,
    required super.quantity,
    required super.measure,
    required super.food,
    required super.weight,
    required super.foodCategory,
    required super.foodId,
    required super.image,
  });
}
