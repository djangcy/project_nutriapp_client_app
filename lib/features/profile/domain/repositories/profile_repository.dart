import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:nutrition_app/features/profile/profile.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ProfileStorage(ref.watch(storageServiceProvider)));
});

class ProfileRepository {
  const ProfileRepository(this._profileStorage);

  final ProfileStorage _profileStorage;

  Future<Either<ProfileModel?, Failure>> getProfile() async {
    try {
      final response = await _profileStorage.getProfile();

      return Left(response);
    } catch (error) {
      Logger.error(
        'Unexpected Error',
        error: error,
      );
      return Right(
        Failure(
          'Unknown Error',
          FailureType.exception,
          code: 500,
        ),
      );
    }
  }

  Future<Either<void, Failure>> setProfile(ProfileModel profile) async {
    try {
      await _profileStorage.saveProfile(profile);

      return const Left(null);
    } catch (error) {
      Logger.error(
        'Unexpected Error',
        error: error,
      );
      return Right(
        Failure(
          'Unknown Error',
          FailureType.exception,
          code: 500,
        ),
      );
    }
  }
}
