import 'package:json_annotation/json_annotation.dart';

part 'recipe_response.g.dart';

@JsonSerializable()
class RecipeResponseModel {
  RecipeResponseModel({
    required this.from,
    required this.to,
    required this.count,
    required this.recipes,
    this.nextUrl,
  });

  factory RecipeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeResponseModelFromJson(json);

  final int from;
  final int to;
  final int count;
  final String? nextUrl;
  final List<Map<String, dynamic>> recipes;
}
