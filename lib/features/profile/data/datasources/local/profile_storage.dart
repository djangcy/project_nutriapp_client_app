import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/profile/profile.dart';

class ProfileStorage {
  const ProfileStorage(this.storage);

  final StorageService storage;

  String get _profileKey => 'profile_storage_profile';

  Future<ProfileModel?> getProfile() async {
    final dynamic profile = storage.get(_profileKey);

    if (profile is Map<dynamic, dynamic>) {
      return ProfileModel.fromJson(Map<String, dynamic>.from(profile));
    } else if (profile is Map<String, dynamic>) {
      return ProfileModel.fromJson(profile);
    }

    return null;
  }

  Future<void> saveProfile(ProfileModel profile) async {
    await storage.set(_profileKey, profile.toJson());
  }
}
