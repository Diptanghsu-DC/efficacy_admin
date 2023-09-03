// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Club _$$_ClubFromJson(Map<String, dynamic> json) => _$_Club(
      description: json['description'] as String,
      socials: (json['socials'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry($enumDecode(_$SocialEnumMap, k), e as String),
          ) ??
          const {},
      email: json['email'] as String,
      phoneNumber: _$JsonConverterFromJson<Map<String, String?>, PhoneNumber>(
          json['phoneNumber'], const PhoneNumberSerializer().fromJson),
      clubLogoURL: json['clubLogoURL'] as String,
      clubBannerURL: json['clubBannerURL'] as String?,
      members: Map<String, String>.from(json['members'] as Map),
      followers: (json['followers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ClubToJson(_$_Club instance) => <String, dynamic>{
      'description': instance.description,
      'socials':
          instance.socials.map((k, e) => MapEntry(_$SocialEnumMap[k]!, e)),
      'email': instance.email,
      'phoneNumber': _$JsonConverterToJson<Map<String, String?>, PhoneNumber>(
          instance.phoneNumber, const PhoneNumberSerializer().toJson),
      'clubLogoURL': instance.clubLogoURL,
      'clubBannerURL': instance.clubBannerURL,
      'members': instance.members,
      'followers': instance.followers,
    };

const _$SocialEnumMap = {
  Social.github: 'github',
  Social.facebook: 'facebook',
  Social.instagram: 'instagram',
  Social.linkedin: 'linkedin',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
