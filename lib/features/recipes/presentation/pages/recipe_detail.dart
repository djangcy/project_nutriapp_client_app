import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/config/config.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class RecipeDetailPage extends ConsumerStatefulWidget {
  const RecipeDetailPage({
    super.key,
    required this.recipeUrl,
  });

  final String recipeUrl;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecipeDetailPageState();
}

class _RecipeDetailPageState extends ConsumerState<RecipeDetailPage> {
  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);

      await launchUrl(uri);
    } on FormatException catch (e) {
      Logger.warning(
        'Invalid recipeUrl Url: '
        '$url\n${e.message}',
      );
    } catch (e) {
      Logger.warning(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(recipeByUriController.notifier).getRecipeByUri(widget.recipeUrl);
    });
  }

  Widget _recipeNotFoundView() {
    return const Center(
      child: Text('We could not find the recipe you are looking for.'),
    );
  }

  Widget _successView() {
    final recipe = ref.watch(recipeByUriProvider);

    if (recipe == null) {
      return _recipeNotFoundView();
    }

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 180,
            width: double.infinity,
            child: Stack(
              children: [
                // Header Image
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Image.network(
                    recipe.image,
                    fit: BoxFit.cover,
                  ),
                ),
                // Header Buttons
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.all(pagePadding.left),
                    child: Row(
                      children: [
                        ThemedIconButton.fill(
                          iconData: Icons.close,
                          onTap: () => context.popRoute(),
                        ),
                        const Spacer(),
                        ThemedIconButton.fill(
                          iconData: Icons.favorite_outline_rounded,
                          onTap: () {
                            // TODO: (EXTRA) add to favourites in profile
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      recipe.label,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.dinner_dining_rounded,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.servings} servings',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.access_time_rounded,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Visibility(
                          visible: recipe.totalTime > 1,
                          child: Text(
                            '${recipe.totalTime} mins',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => _launchUrl(recipe.recipeUrl),
                  child: Text(
                    'View Original',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.apply(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cautions',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Wrap(
                      children: [
                        Text(
                          recipe.cautions.join(', '),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // TODO: (EXTRA) nutritional information (formatted as label, if possible)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ingredients',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Wrap(
                      children: [
                        ...recipe.ingredients.map(
                          (e) {
                            return Text(
                              e.text,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instructions',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Wrap(
                      children: [
                        Text(
                          recipe.ingredientLines.join('\n'),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // TODO: create separate widget (recipe carousel)
                // TODO: query similar recipes based on input uri/recipe?
                Column(
                  children: [
                    const NavigationHeader(text: 'Similar Recipes'),
                    SizedBox(
                      width: double.infinity,
                      child: RecipeGridView(
                        children: [
                          ...List.generate(
                            5,
                            (index) {
                              return RecipeInfoBlock.fromRecipe(
                                recipe: recipe,
                                onTap: () => context.pushRoute(
                                  RecipeDetailRoute(recipeUrl: recipe.uri),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: pagePadding.left),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipeByUriState = ref.watch(recipeByUriController);

    return recipeByUriState.map(
      initial: (_) => const SizedBox.shrink(),
      loading: (_) => const Center(child: CircularProgressIndicator()),
      success: (success) => _successView(),
      error: (_) => const ErrorView(),
    );
  }
}
