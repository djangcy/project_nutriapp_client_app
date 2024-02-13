import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/profile/profile.dart';

final currentProfileController = StateNotifierProvider.autoDispose<
    ProfileController<ProfileModel>, BaseState<dynamic>>(
  _profileController,
);

ProfileController<T> _profileController<T>(Ref ref) {
  return ProfileController<T>(ref);
}

class ProfileController<T> extends StateNotifier<BaseState<dynamic>> {
  ProfileController(this.ref) : super(const BaseState<void>.initial());

  final Ref ref;

  ProfileRepository get _profileRepository =>
      ref.read(profileRepositoryProvider);

  Future<void> getProfile() async {
    state = const BaseState.loading();

    final response = await _profileRepository.getProfile();

    state = response.fold(
      (success) {
        ref.read(currentProfileProvider.notifier).state = success;

        return BaseState<ProfileModel?>.success(data: success);
      },
      BaseState.error,
    );
  }

  Future<void> setProfile(ProfileModel profile) async {
    await _profileRepository.setProfile(profile);

    await getProfile();
  }
}
