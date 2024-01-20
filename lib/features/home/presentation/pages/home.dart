import 'package:flutter/material.dart';
import 'package:nutrition_app/config/config.dart';
import 'package:nutrition_app/core/widgets/widgets.dart';
import 'package:nutrition_app/features/home/home.dart';
import 'package:nutrition_app/features/recipes/recipes.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: pagePadding,
          children: [
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Good Evening', // TODO: Get from l10n, time data
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                          text: '\nDana', // TODO: Get from data
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.account_circle,
                    size: 28,
                  ),
                ],
              ),
            ),
            PrimaryFullSearchBar(
              focusNode: FocusNode(),
              hintText:
                  'What can I make for dinner in 20 minutes?', // TODO: Get from l10n
              onTap: () {
                // Removes focus after tapping
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final FocusScopeNode focus = FocusScope.of(context);
                  if (!focus.hasPrimaryFocus) {
                    focus.focusedChild?.unfocus();
                  }
                });
                // TODO: Create a bottom sheet that covers the screen, for searching. Use hero for search bar
                SearchBottomSheet.show(context);
              },
            ),
            const DiscoverRecipesBlock(),
          ],
        ),
      ),
    );
  }
}
