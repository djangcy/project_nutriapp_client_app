import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

class RecipeInfoBlock extends StatelessWidget {
  const RecipeInfoBlock({
    super.key,
    this.recipeName = '',
    this.imageUrl,
    this.servingsText = '-',
    this.cookingTimeText = '-',
    this.onTap,
  });

  RecipeInfoBlock.fromRecipe({
    super.key,
    required RecipeModel recipe,
    this.onTap,
  })  : recipeName = recipe.label,
        imageUrl = recipe.image,
        servingsText = '${recipe.servings}',
        cookingTimeText = '${recipe.totalTime}';

  final String recipeName;
  final String? imageUrl;
  final String servingsText;
  final String cookingTimeText;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 170,
        width: 170,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
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
            AutoSizeText(
              recipeName,
              style: Theme.of(context).textTheme.titleSmall,
              minFontSize: 10,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.dinner_dining_rounded,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    servingsText,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.access_time_rounded,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    cookingTimeText,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
