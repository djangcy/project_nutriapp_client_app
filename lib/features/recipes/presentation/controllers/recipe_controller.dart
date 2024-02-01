import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

final searchRecipesController = StateNotifierProvider.autoDispose<
    RecipesController<PaginatedResponse<RecipeEntity>>, BaseState<dynamic>>(
  _recipesController,
);

final queryRecipesController = StateNotifierProvider.autoDispose<
    RecipesController<PaginatedResponse<RecipeEntity>>, BaseState<dynamic>>(
  _recipesController,
);

final recipeByUriController = StateNotifierProvider.autoDispose<
    RecipesController<PaginatedResponse<RecipeEntity>>, BaseState<dynamic>>(
  _recipesController,
);

RecipesController<T> _recipesController<T>(Ref ref) {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);
  return RecipesController<T>(ref);
}

class RecipesController<T> extends StateNotifier<BaseState<dynamic>> {
  RecipesController(this.ref, {this.cancelToken})
      : super(const BaseState<void>.initial());

  final CancelToken? cancelToken;

  final Ref ref;

  // RecipeRepository get _recipeRepository =>
  //     ref.read(dummyRecipeRepositoryProvider);

  RecipeRepository get _recipeRepository => ref.read(recipeRepositoryProvider);

  // TODO: (extra) add 'getRecommendedRecipes' that reads from '/recommended' endpoint.

  Future<void> searchRecipes({
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
    state = const BaseState<void>.loading();

    final response = await _recipeRepository.getRecipes(
      query: query,
      from: from,
      to: to,
      calories: calories,
      cuisineType: cuisineType,
      diet: diet,
      dishType: dishType,
      excluded: excluded,
      health: health,
      ingr: ingr,
      mealType: mealType,
      time: time,
      type: type,
    );

    state = response.fold(
      (success) {
        final previousData = ref.read(searchRecipesProvider);

        ref.read(searchRecipesProvider.notifier).state =
            ref.read(searchRecipesProvider).copyWith(
                  limit: success.limit,
                  page: success.page,
                  nextPage: success.page + 1,
                  totalResults: success.totalResults,
                  results: [...previousData.results, ...success.results]
                      .unique((e) => e.uri),
                  isEnd: success.page * success.limit == success.totalResults,
                );

        return BaseState<PaginatedResponse<RecipeModel>>.success(
          data: success,
        );
      },
      BaseState.error,
    );
  }

  Future<void> getRecipeByUri(String uri) async {
    state = const BaseState<void>.loading();

    final response = await _recipeRepository.getRecipeByUri(uri: uri);

    state = response.fold(
      (success) {
        ref.read(recipeByUriProvider.notifier).state = success;

        return BaseState<RecipeModel>.success(data: success);
      },
      BaseState.error,
    );
  }

  Future<void> queryRecipes(String query) async {
    state = const BaseState<void>.loading();

    final response = await _recipeRepository.getRecipesByQuery(
      query: RecipeQueryBody(query),
    );

    state = response.fold(
      (success) {
        ref.read(queryRecipesProvider.notifier).state = success;

        return BaseState<PaginatedResponse<RecipeModel>>.success(data: success);
      },
      BaseState.error,
    );
  }
}
