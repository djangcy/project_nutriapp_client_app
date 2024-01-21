import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/core/errors/failure.dart';
import 'package:nutrition_app/core/models/paginated_response.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

final dummyRecipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return DummyRecipeRepository();
});

class DummyRecipeRepository implements RecipeRepository {
  @override
  Future<Either<RecipeEntity, Failure>> getRecipeById({
    required String id,
    String? type,
  }) {
    return Future.value(Left(_samples[0] as RecipeEntity));
  }

  @override
  Future<Either<RecipeModel?, Failure>> getRecipeByUri({
    required String uri,
    String? type,
  }) {
    return Future.value(Left(_samples[0]));
  }

  @override
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
  }) {
    return Future.value(
      Left(
        PaginatedResponse(
          page: 1,
          nextPage: 2,
          results: _samples,
          totalResults: _samples.length,
        ),
      ),
    );
  }

  @override
  Future<Either<PaginatedResponse<RecipeModel>, Failure>> getRecipesByQuery({
    required RecipeQueryBody query,
  }) {
    return Future.value(
      Left(
        PaginatedResponse(
          page: 1,
          nextPage: 2,
          results: _samples,
          totalResults: _samples.length,
        ),
      ),
    );
  }
}

final List<RecipeModel> _samples = List.generate(
  12,
  (index) => RecipeModel(
    calories: 633.34,
    cautions: [],
    cuisineType: ['french'],
    dietLabels: ['High-Protein', 'Low-Carb', 'Low-Sodium'],
    dishType: ['condiments and sauces'],
    healthLabels: [
      'Sugar-Conscious',
      'Keto-Friendly',
      'Paleo',
      'Dairy-Free',
      'Gluten-Free',
      'Wheat-Free',
      'Egg-Free',
      'Peanut-Free',
      'Tree-Nut-Free',
      'Soy-Free',
      'Fish-Free',
      'Shellfish-Free',
      'Pork-Free',
      'Crustacean-Free',
      'Celery-Free',
      'Mustard-Free',
      'Sesame-Free',
      'Lupine-Free',
      'Mollusk-Free',
      'Alcohol-Free',
      'Sulfite-Free'
    ],
    image: 'https://picsum.photos/500',
    ingredientLines: [
      '1 oz. filet mignon beef steaks',
      '1 tbsp extra virgin olive oil',
      '1 clove garlic',
      '1 meat tenderizer',
      'Freshly ground black pepper',
    ],
    ingredients: [
      Ingredient(
        text: '1 oz. filet mignon beef steaks',
        quantity: 1,
        measure: 'ounce',
        food: 'beef steaks',
        weight: 28.35,
        foodId: 'food_aregbrwb5q7z2db1h14uxaizfd9f',
        image:
            'https://www.edamam.com/food-img/4d2/4d2ae7e6fd2145d4c89a8ffae7d4f2b7.jpg',
      ),
      Ingredient(
        text: '1 tbsp extra virgin olive oil',
        quantity: 1,
        measure: 'tablespoon',
        food: 'extra virgin olive oil',
        weight: 13.5,
        foodId: 'food_b1d1icuad3iktrbqby0hiagafaz7',
        image:
            'https://www.edamam.com/food-img/4d6/4d651eaa8a353647746290c7a9b29d84.jpg',
      ),
      Ingredient(
        text: '1 clove garlic',
        quantity: 1,
        measure: 'clove',
        food: 'garlic',
        weight: 3,
        foodId: 'food_avtcmx6bgjv1jvay6s6stan8dnyp',
        image:
            'https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg',
      ),
      Ingredient(
        text: '1 meat tenderizer',
        quantity: 1,
        food: 'meat',
        weight: 340,
        foodId: 'food_bknby1la98smrsbwnthinbam42nj',
        image:
            'https://www.edamam.com/food-img/bab/bab88ab3ea40d34e4c8ae35d6b30344a.jpg',
      ),
      Ingredient(
        text: 'Freshly ground black pepper',
        quantity: 0,
        food: 'black pepper',
        weight: 1.1545485693750002,
        foodId: 'food_b6ywzluaaxv02wad7s1r9ag4py89',
        image:
            'https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg',
      ),
    ],
    label: 'Pan-seared Garlic Filet Mignon Beef Steak',
    mealType: ['lunch/dinner'],
    recipeUrl:
        'http://www.bigoven.com/recipe/Pan-seared-Garlic-Filet-Mignon-Beef-Steak/177702',
    servings: 3,
    source: 'BigOven',
    totalNutrients: {},
    totalTime: 30,
    totalWeight: 386,
    uri:
        'http://www.edamam.com/ontologies/edamam.owl#recipe_70696eb55a49df07753c027f0c0462f3$index',
  ),
);
