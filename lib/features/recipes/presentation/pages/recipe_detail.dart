import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/config/config.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/profile/presentation/controllers/controllers.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../profile/presentation/providers/providers.dart';

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
  late int _tabIndex = 0;

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);

      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } on FormatException catch (e) {
      Logger.warning(
        'Invalid recipeUrl Url: '
        '$url\n${e.message}',
      );
    } catch (e) {
      Logger.warning(e.toString());
    }
  }

  void _loadLikedRecipe() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(likedRecipesController.notifier)
          .getLikedRecipeByUri(widget.recipeUrl);
    });
  }

  void _loadRecipe() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(recipesController.notifier).getRecipeByUri(widget.recipeUrl);
    });
  }

  @override
  void initState() {
    super.initState();

    _tabIndex = 0;

    _loadRecipe();
    _loadLikedRecipe();
  }

  Widget _recipeNotFoundView() {
    return const Center(
      child: Text('We could not find the recipe you are looking for.'),
    );
  }

  Widget _successView() {
    final recipe = ref.watch(currentRecipeProvider);
    final likedRecipe = ref.watch(likedRecipeByUriProvider);

    if (recipe == null) {
      return _recipeNotFoundView();
    }

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 240,
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
                    errorBuilder: (context, error, _) {
                      return const Center(child: Text('Error Loading Image'));
                    },
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
                          iconData: Icons.arrow_back_rounded,
                          onTap: () => context.popRoute(),
                        ),
                        const Spacer(),
                        Builder(
                          builder: (context) {
                            final bool isLiked = likedRecipe != null;

                            return ThemedIconButton.fill(
                              iconData: isLiked
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_outline_rounded,
                              onTap: () {
                                if (isLiked) {
                                  ref
                                      .read(likedRecipesController.notifier)
                                      .removeLikedRecipe(recipe.uri);
                                } else {
                                  ref
                                      .read(likedRecipesController.notifier)
                                      .addLikedRecipe(recipe);
                                }
                                _loadLikedRecipe();
                              },
                            );
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
                // Title Text
                AutoSizeText(
                  recipe.label,
                  maxLines: 2,
                  presetFontSizes: const [24, 18],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Recipe Info
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    RecipeInfoPip.large(
                      text: '🔥 ${recipe.calories.toInt()} Kcal',
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    RecipeInfoPip.large(
                      text: '⏰ ${recipe.totalTime.toInt()} Mins',
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    RecipeInfoPip.large(
                      text: '🍽 ${recipe.servings} Servings',
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Source Link
                InkWell(
                  onTap: () => _launchUrl(recipe.recipeUrl),
                  child: Text(
                    'Original Recipe',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 16),
                // Tabs
                RecipeTabsWidget(
                  onChanged: (index) => setState(() {
                    _tabIndex = index;
                  }),
                ),
                // Tab Contents
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: switch (_tabIndex) {
                    0 =>
                      // Ingredients
                      ReadMoreText(
                        recipe.ingredientLines.join('\n'),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    1 =>
                      // Health
                      RecipeTagsWidget(
                        values: recipe.healthLabels,
                      ),
                    2 =>
                      // Cautions
                      RecipeTagsWidget(
                        values: recipe.cautions,
                      ),
                    _ => Container()
                  },
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
    final recipeByUriState = ref.watch(recipesController);

    return recipeByUriState.map(
      initial: (_) => const SizedBox.shrink(),
      loading: (_) => const Center(child: CircularProgressIndicator()),
      success: (success) => _successView(),
      error: (_) => const ErrorView(),
    );
  }
}
