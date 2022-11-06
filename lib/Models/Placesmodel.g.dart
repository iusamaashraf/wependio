// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Placesmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Placesmodel _$PlacesmodelFromJson(Map<String, dynamic> json) => Placesmodel(
      country: json['country'] as String?,
      name: json['name'] as String?,
      created_at: json['created_at'] as String?,
      default_currency_code: json['default_currency_code'] as String?,
      featured: json['featured'] as int?,
      id: json['id'] as int?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      parent_id: json['parent_id'] as int?,
      region: json['region'] as String?,
      timezone: json['timezone'] as String?,
      updated_at: json['updated_at'] as String?,
      viator_destination_id: json['viator_destination_id'] as String?,
      viator_destination_type: json['viator_destination_type'] as String?,
      viator_iata_code: json['viator_iata_code'] as String?,
      viator_lookup_id: json['viator_lookup_id'] as String?,
    );

Map<String, dynamic> _$PlacesmodelToJson(Placesmodel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'featured': instance.featured,
      'parent_id': instance.parent_id,
      'name': instance.name,
      'region': instance.region,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'default_currency_code': instance.default_currency_code,
      'timezone': instance.timezone,
      'viator_lookup_id': instance.viator_lookup_id,
      'viator_iata_code': instance.viator_iata_code,
      'viator_destination_id': instance.viator_destination_id,
      'viator_destination_type': instance.viator_destination_type,
    };
