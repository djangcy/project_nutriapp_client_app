import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/config/routes/routes.dart';
import 'package:nutrition_app/core/widgets/widgets.dart';
import 'package:nutrition_app/features/profile/profile.dart';

@RoutePage()
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  void _loadProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(currentProfileController.notifier).getProfile();
    });
  }

  @override
  void initState() {
    super.initState();

    _loadProfile();
  }

  Widget _profileNotFoundView() {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: Column(
        children: [
          const Center(
            child: Text('We could not find your profile.'),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.surface,
              ),
            ),
            onPressed: () =>
                ref.read(currentProfileController.notifier).setProfile(
                      const ProfileModel(
                        name: 'Dana',
                        surname: 'Fernandez',
                        imageUrl:
                            'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=600',
                      ),
                    ),
            child: Text(
              'Click Here To Make A Profile!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _successView() {
    final profile = ref.watch(currentProfileProvider);

    if (profile == null) {
      return _profileNotFoundView();
    }

    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: profile.imageUrl == null
                      ? const Placeholder()
                      : Image(
                          image: NetworkImage(profile.imageUrl!),
                          fit: BoxFit.fill,
                        ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${profile.name} ${profile.surname}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Liked Recipes ♥',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: LikedRecipeList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentProfileState = ref.watch(currentProfileController);

    return currentProfileState.map(
      initial: (_) => const SizedBox.shrink(),
      loading: (_) => const Center(child: CircularProgressIndicator()),
      success: (success) => _successView(),
      error: (_) => const ErrorView(),
    );
  }
}
