// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    pk: json['pk'] as String?,
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    username: json['username'] as String?,
    email: json['email'] as String?,
    birthdate: json['birthdate'] as String?,
    timezone: json['timezone'] as String?,
    image: json['image'] as String?,
    dailyProgress: (json['daily_progress'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'pk': instance.pk,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'username': instance.username,
      'email': instance.email,
      'birthdate': instance.birthdate,
      'timezone': instance.timezone,
      'image': instance.image,
      'daily_progress': instance.dailyProgress,
    };
