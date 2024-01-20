import 'package:dio/dio.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';
import 'package:retrofit/retrofit.dart';

part 'recipe_api_client.g.dart';

@RestApi()
abstract class RecipeSearchApiClient {
  factory RecipeSearchApiClient(Dio http) = _RecipeSearchApiClient;

  @GET('/api/recipe-search/')
  Future<RecipeResponseModel> getRecipes({
    @Query('q') required String query,
    @Query('type') String? type,
    @Query('from') int? from,
    @Query('to') int? to,
    @Query('ingr') int? ingr,
    @Query('diet') List<String>? diet,
    @Query('health') List<String>? health,
    @Query('cuisineType') List<String>? cuisineType,
    @Query('mealType') List<String>? mealType,
    @Query('dishType') List<String>? dishType,
    @Query('calories') String? calories,
    @Query('time') String? time,
    @Query('excluded') List<String>? excluded,
  });

  @GET('/api/recipe-search/by-uri')
  Future<RecipeResponseModel> getRecipeByUri({
    @Query('uri') required String uri,
    @Query('type') String? type,
  });

  @POST('/api/recipe-search/query')
  Future<RecipeResponseModel> getRecipesByQuery({
    @Body() required RecipeQueryBody body,
  });

  @GET('/api/recipe-search/recipes/{id}')
  Future<RecipeResponseModel> getRecipeById({
    @Path('id') required String id,
    @Query('type') String? type,
  });
}
