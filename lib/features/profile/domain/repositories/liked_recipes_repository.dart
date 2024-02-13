import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/profile/profile.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

final likedRecipesRepositoryProvider = Provider<LikedRecipesRepository>((ref) {
  return LikedRecipesRepository(
      LikedRecipesStorage(ref.watch(storageServiceProvider)));
});

class LikedRecipesRepository {
  const LikedRecipesRepository(this._likedRecipesStorage);

  final LikedRecipesStorage _likedRecipesStorage;

  Future<Either<List<RecipeModel>, Failure>> getLikedRecipes() async {
    try {
      final response = await _likedRecipesStorage.getLikedRecipes();

      print('Response: $response');

      return Left(response);
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

  Future<Either<RecipeModel?, Failure>> getLikedRecipesByUri(
    String uri,
  ) async {
    try {
      final response = await _likedRecipesStorage.getLikedRecipes();

      print('Response: $response');

      final matches = response.where((e) => e.uri == uri).toList();

      if (matches.isNotEmpty) {
        return Left(matches.first);
      } else {
        return const Left(null);
      }
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

  Future<Either<List<RecipeModel>, Failure>> getLikedRecipesByUris(
    List<String> uris,
  ) async {
    try {
      final response = await _likedRecipesStorage.getLikedRecipes();

      final matches = response.where((e) => uris.contains(e.uri)).toList();

      return Left(matches);
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

  Future<Either<void, Failure>> addLikedRecipe(RecipeModel likedRecipe) async {
    try {
      await _likedRecipesStorage.addLikedRecipe(likedRecipe);

      return const Left(null);
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

  Future<Either<void, Failure>> removeLikedRecipe(
    String likedRecipeUri,
  ) async {
    try {
      await _likedRecipesStorage.removeLikedRecipe(likedRecipeUri);

      return const Left(null);
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
