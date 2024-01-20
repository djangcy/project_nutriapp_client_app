// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
      uri: json['uri'] as String,
      label: json['label'] as String,
      image: json['image'] as String,
      source: json['source'] as String,
      recipeUrl: json['recipeUrl'] as String,
      servings: json['servings'] as int,
      dietLabels: (json['dietLabels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      healthLabels: (json['healthLabels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      cautions:
          (json['cautions'] as List<dynamic>).map((e) => e as String).toList(),
      ingredientLines: (json['ingredientLines'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      calories: (json['calories'] as num).toDouble(),
      totalWeight: (json['totalWeight'] as num).toDouble(),
      totalTime: (json['totalTime'] as num).toDouble(),
      cuisineType: (json['cuisineType'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      mealType:
          (json['mealType'] as List<dynamic>).map((e) => e as String).toList(),
      dishType: (json['dishType'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      totalNutrients: (json['totalNutrients'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Nutrient.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'label': instance.label,
      'image': instance.image,
      'source': instance.source,
      'recipeUrl': instance.recipeUrl,
      'servings': instance.servings,
      'dietLabels': instance.dietLabels,
      'healthLabels': instance.healthLabels,
      'cautions': instance.cautions,
      'ingredientLines': instance.ingredientLines,
      'ingredients': instance.ingredients,
      'calories': instance.calories,
      'totalWeight': instance.totalWeight,
      'totalTime': instance.totalTime,
      'cuisineType': instance.cuisineType,
      'mealType': instance.mealType,
      'dishType': instance.dishType,
      'totalNutrients': instance.totalNutrients,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      text: json['text'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      food: json['food'] as String,
      weight: (json['weight'] as num).toDouble(),
      foodId: json['foodId'] as String,
      foodCategory: json['foodCategory'] as String?,
      measure: json['measure'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'text': instance.text,
      'quantity': instance.quantity,
      'food': instance.food,
      'weight': instance.weight,
      'foodId': instance.foodId,
      'foodCategory': instance.foodCategory,
      'measure': instance.measure,
      'image': instance.image,
    };

Nutrient _$NutrientFromJson(Map<String, dynamic> json) => Nutrient(
      label: json['label'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$NutrientToJson(Nutrient instance) => <String, dynamic>{
      'label': instance.label,
      'quantity': instance.quantity,
      'unit': instance.unit,
    };
