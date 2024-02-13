import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

class IngredientsSerializer
    implements JsonConverter<List<Ingredient>, List<dynamic>> {
  const IngredientsSerializer();

  @override
  List<Ingredient> fromJson(List<dynamic> jsonList) {
    if (jsonList is List<Map<String, dynamic>>) {
      return jsonList.map(Ingredient.fromJson).toList();
    } else {
      return jsonList
          .map(
            (e) => Ingredient.fromJson(
              Map<String, dynamic>.from(e as Map<String, dynamic>),
            ),
          )
          .toList();
    }
  }

  @override
  List<Map<String, dynamic>> toJson(List<Ingredient> objectList) =>
      objectList.map((e) => e.toJson()).toList();
}
