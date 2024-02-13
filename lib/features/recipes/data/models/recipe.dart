import 'package:json_annotation/json_annotation.dart';

import 'recipe_serializers.dart';

part 'recipe.g.dart';

@JsonSerializable(explicitToJson: true)
class RecipeModel {
  RecipeModel({
    required this.uri,
    required this.label,
    required this.image,
    required this.source,
    required this.recipeUrl,
    required this.servings,
    required this.dietLabels,
    required this.healthLabels,
    required this.cautions,
    required this.ingredientLines,
    required this.ingredients,
    required this.calories,
    required this.totalWeight,
    required this.totalTime,
    required this.cuisineType,
    required this.mealType,
    required this.dishType,
    required this.totalNutrients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);

  final String uri;
  final String label;
  final String image;
  final String source;
  final String recipeUrl;
  final int servings;
  final List<String> dietLabels;
  final List<String> healthLabels;
  final List<String> cautions;
  final List<String> ingredientLines;
  @IngredientsSerializer()
  final List<Ingredient> ingredients;
  final double calories;
  final double totalWeight;
  final double totalTime;
  final List<String> cuisineType;
  final List<String> mealType;
  final List<String>? dishType;
  final Map<String, Nutrient> totalNutrients;
}

@JsonSerializable(explicitToJson: true)
class Ingredient {
  Ingredient({
    required this.text,
    required this.quantity,
    required this.food,
    required this.weight,
    required this.foodId,
    this.foodCategory,
    this.measure,
    this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  final String text;
  final double quantity;
  final String food;
  final double weight;
  final String foodId;
  final String? foodCategory;
  final String? measure;
  final String? image;

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Nutrient {
  Nutrient({
    required this.label,
    required this.quantity,
    required this.unit,
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) =>
      _$NutrientFromJson(json);

  final String label;
  final double quantity;
  final String unit;

  Map<String, dynamic> toJson() => _$NutrientToJson(this);
}
