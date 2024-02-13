import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/profile/profile.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

final likedRecipesController = StateNotifierProvider.autoDispose<
    LikedRecipesController<PaginatedResponse<RecipeModel>>, BaseState<dynamic>>(
  _likedRecipesController,
);

LikedRecipesController<T> _likedRecipesController<T>(Ref ref) {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);
  return LikedRecipesController<T>(ref);
}

class LikedRecipesController<T> extends StateNotifier<BaseState<dynamic>> {
  LikedRecipesController(this.ref, {this.cancelToken})
      : super(const BaseState<void>.initial());

  final CancelToken? cancelToken;

  final Ref ref;

  LikedRecipesRepository get _likedRecipesRepository =>
      ref.read(likedRecipesRepositoryProvider);

  Future<void> getLikedRecipeByUri(String uri) async {
    state = const BaseState<void>.loading();

    final response = await _likedRecipesRepository.getLikedRecipesByUri(uri);

    state = response.fold(
      (success) {
        ref.read(likedRecipeByUriProvider.notifier).state = success;

        return BaseState<RecipeModel?>.success(data: success);
      },
      BaseState.error,
    );
  }

  Future<void> getLikedRecipes() async {
    state = const BaseState<void>.loading();

    final response = await _likedRecipesRepository.getLikedRecipes();

    state = response.fold(
      (success) {
        ref.read(likedRecipesProvider.notifier).state = success;

        return BaseState<List<RecipeModel>>.success(data: success);
      },
      BaseState.error,
    );
  }

  Future<void> addLikedRecipe(RecipeModel recipe) async {
    await _likedRecipesRepository.addLikedRecipe(recipe);
  }

  Future<void> removeLikedRecipe(String recipeUri) async {
    await _likedRecipesRepository.removeLikedRecipe(recipeUri);
  }
}
