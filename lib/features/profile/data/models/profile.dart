import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class ProfileModel {
  const ProfileModel({
    required this.name,
    required this.surname,
    this.imageUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  final String name;
  final String surname;
  final String? imageUrl;
}
