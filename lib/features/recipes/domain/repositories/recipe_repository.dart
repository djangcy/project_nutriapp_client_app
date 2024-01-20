import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

final recipeSearchRepositoryProvider = Provider<RecipeSearchRepository>((ref) {
  return RecipeSearchRepository(RecipeSearchApiClient(DioHttp.dioHttpClient));
});

class RecipeSearchRepository {
  const RecipeSearchRepository(this._recipeSearchApiClient);

  final RecipeSearchApiClient _recipeSearchApiClient;

  Future<Either<PaginatedResponse<RecipeModel>, Failure>> getRecipes({
    required String query,
    String? type,
    int? from,
    int? to,
    int? ingr,
    List<String>? diet,
    List<String>? health,
    List<String>? cuisineType,
    List<String>? mealType,
    List<String>? dishType,
    String? calories,
    String? time,
    List<String>? excluded,
  }) async {
    try {
      final response = await _recipeSearchApiClient.getRecipes(
        query: query,
        type: type,
        from: from,
        to: to,
        ingr: ingr,
        diet: diet,
        health: health,
        cuisineType: cuisineType,
        mealType: mealType,
        dishType: dishType,
        calories: calories,
        time: time,
        excluded: excluded,
      );

      return Left(
        PaginatedResponse(
          page: response.from ~/ (response.to - response.from),
          isEnd: response.to >= response.count,
          totalResults: response.count,
          limit: response.to - response.from,
          results: response.recipes.map(RecipeModel.fromJson).toList(),
        ),
      );
    } on DioException catch (error) {
      Logger.error(
        error.message ?? 'Unknown Error',
        error: error.error,
      );
      return Right(error.toFailure);
    } catch (error) {
      Logger.error(
        'Unexpected Error',
        error: error,
      );
      return Right(
        Failure(
          'Unknown Error',
          FailureType.exception,
          code: 500,
        ),
      );
    }
  }

  Future<Either<RecipeModel?, Failure>> getRecipeByUri({
    required String uri,
    String? type,
  }) async {
    try {
      final response = await _recipeSearchApiClient.getRecipeByUri(
        uri: uri,
        type: type,
      );

      RecipeModel? recipe;
      if (response.recipes.isNotEmpty) {
        recipe = RecipeModel.fromJson(response.recipes.first);
      }

      return Left(recipe);
    } on DioException catch (error) {
      Logger.error(
        error.message ?? 'Unknown Error',
        error: error.error,
      );
      return Right(error.toFailure);
    } catch (error) {
      Logger.error(
        'Unexpected Error',
        error: error,
      );
      return Right(
        Failure(
          'Unknown Error',
          FailureType.exception,
          code: 500,
        ),
      );
    }
  }

  Future<Either<RecipeEntity, Failure>> getRecipeById({
    required String id,
    String? type,
  }) async {
    try {
      final response = await _recipeSearchApiClient.getRecipeById(
        id: id,
        type: type,
      );

      return Left(response as RecipeEntity);
    } on DioException catch (error) {
      Logger.error(
        error.message ?? 'Unknown Error',
        error: error.error,
      );
      return Right(error.toFailure);
    } catch (error) {
      Logger.error(
        'Unexpected Error',
        error: error,
      );
      return Right(
        Failure(
          'Unknown Error',
          FailureType.exception,
          code: 500,
        ),
      );
    }
  }

  Future<Either<PaginatedResponse<RecipeModel>, Failure>> getRecipesByQuery({
    required RecipeQueryBody query,
  }) async {
    try {
      final response = await _recipeSearchApiClient.getRecipesByQuery(
        body: query,
      );

      return Left(
        PaginatedResponse(
          page: response.from ~/ (response.to - response.from),
          isEnd: response.to >= response.count,
          totalResults: response.count,
          limit: response.to - response.from,
          results: response.recipes.map(RecipeModel.fromJson).toList(),
        ),
      );
    } on DioException catch (error) {
      Logger.error(
        error.message ?? 'Unknown Error',
        error: error.error,
      );
      return Right(error.toFailure);
    } catch (error) {
      Logger.error(
        'Unexpected Error',
        error: error,
      );
      return Right(
        Failure(
          'Unknown Error',
          FailureType.exception,
          code: 500,
        ),
      );
    }
  }
}
