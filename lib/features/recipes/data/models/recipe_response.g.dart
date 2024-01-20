// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeResponseModel _$RecipeResponseModelFromJson(Map<String, dynamic> json) =>
    RecipeResponseModel(
      from: json['from'] as int,
      to: json['to'] as int,
      count: json['count'] as int,
      recipes: (json['recipes'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      nextUrl: json['nextUrl'] as String?,
    );

Map<String, dynamic> _$RecipeResponseModelToJson(
        RecipeResponseModel instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'count': instance.count,
      'nextUrl': instance.nextUrl,
      'recipes': instance.recipes,
    };
