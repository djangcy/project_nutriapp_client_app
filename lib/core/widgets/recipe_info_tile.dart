import 'package:flutter/material.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/recipes/data/data.dart';

class RecipeInfoTile extends StatelessWidget {
  RecipeInfoTile.fromRecipe({
    super.key,
    required RecipeModel recipe,
    this.onTap,
  })  : recipeName = recipe.label,
        imageUrl = recipe.image,
        caloriesText = '${recipe.calories.toInt()}',
        servingsText = '${recipe.servings}',
        cookingTimeText = '${recipe.totalTime.toInt()}';

  final String recipeName;
  final String? imageUrl;
  final String caloriesText;
  final String servingsText;
  final String cookingTimeText;

  final void Function()? onTap;

  Widget buildContainer(
    BuildContext context, {
    required Widget child,
  }) {
    try {
      return Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          image: imageUrl == null
              ? null
              : DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                  opacity: 0.7,
                  colorFilter: const ColorFilter.srgbToLinearGamma(),
                ),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: child,
      );
    } catch (_) {
      return Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: child,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(16),
        child: buildContainer(
          context,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipeName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                Row(
                  children: [
                    RecipeInfoPip(
                      text: '🔥 $caloriesText',
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 12),
                    RecipeInfoPip(
                      text: '⏰ $cookingTimeText',
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 12),
                    RecipeInfoPip(
                      text: '🍽 $servingsText',
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
