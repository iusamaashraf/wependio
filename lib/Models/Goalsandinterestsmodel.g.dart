// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Goalsandinterestsmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goalsandinterestsmodel _$GoalsandinterestsmodelFromJson(
        Map<String, dynamic> json) =>
    Goalsandinterestsmodel(
      name: json['name'] as String?,
      updated_at: json['updated_at'] as String?,
      id: json['id'] as int?,
      created_at: json['created_at'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$GoalsandinterestsmodelToJson(
        Goalsandinterestsmodel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
