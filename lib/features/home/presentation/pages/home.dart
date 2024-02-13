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
                  const GreetingTitleWidget(),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      size: 28,
                    ),
                    onPressed: () => context.router.push(const ProfileRoute()),
                  ),
                ],
              ),
            ),
            PrimaryFullSearchBar(
              focusNode: FocusNode(),
              hintText: 'What can I make for dinner in 20 minutes?',
              onTap: () {
                // Removes focus after tapping
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final FocusScopeNode focus = FocusScope.of(context);
                  if (!focus.hasPrimaryFocus) {
                    focus.focusedChild?.unfocus();
                  }
                });
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
