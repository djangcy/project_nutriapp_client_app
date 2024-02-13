import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

class RecipeInfoBlock extends StatelessWidget {
  // const RecipeInfoBlock({
  //   super.key,
  //   this.recipeName = '',
  //   this.imageUrl,
  //   this.caloriesText = '-',
  //   this.servingsText = '-',
  //   this.cookingTimeText = '-',
  //   this.onTap,
  // });

  RecipeInfoBlock.fromRecipe({
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 165,
          width: 170,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: imageUrl == null
                    ? Container()
                    : Image(
                        image: NetworkImage(imageUrl!),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container();
                        },
                      ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 14,
                child: AutoSizeText(
                  recipeName,
                  style: Theme.of(context).textTheme.titleSmall,
                  presetFontSizes: const [12, 10, 8],
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    RecipeInfoPip.small(
                      text: '🔥 $caloriesText',
                    ),
                    RecipeInfoPip.small(
                      text: '⏰ $cookingTimeText',
                    ),
                    RecipeInfoPip.small(
                      text: '🍽 $servingsText',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
