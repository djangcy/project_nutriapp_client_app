import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/config/config.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';
import 'package:readmore/readmore.dart';
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

  @override
  void initState() {
    super.initState();

    _tabIndex = 0;

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
                    RecipeInfoPip(
                      text: '🔥 ${recipe.calories.toInt()} Kcal',
                    ),
                    RecipeInfoPip(
                      text: '⏰ ${recipe.totalTime.toInt()} Mins',
                    ),
                    RecipeInfoPip(
                      text: '🍽 ${recipe.servings} Servings',
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
                        startColor: Colors.green,
                        values: recipe.healthLabels,
                      ),
                    2 =>
                      // Cautions
                      RecipeTagsWidget(
                        startColor: Colors.orange,
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
    final recipeByUriState = ref.watch(recipeByUriController);

    return recipeByUriState.map(
      initial: (_) => const SizedBox.shrink(),
      loading: (_) => const Center(child: CircularProgressIndicator()),
      success: (success) => _successView(),
      error: (_) => const ErrorView(),
    );
  }
}
