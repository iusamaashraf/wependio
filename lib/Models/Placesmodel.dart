import 'package:json_annotation/json_annotation.dart';
part 'Placesmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Placesmodel {
  dynamic? id, featured, parent_id;
  dynamic? name,
      region,
      country,
      latitude,
      longitude,
      created_at,
      updated_at,
      default_currency_code,
      timezone,
      viator_lookup_id,
      viator_iata_code,
      viator_destination_id,
      viator_destination_type;
  Placesmodel(
      {this.country,
      this.name,
      this.created_at,
      this.default_currency_code,
      this.featured,
      this.id,
      this.latitude,
      this.longitude,
      this.parent_id,
      this.region,
      this.timezone,
      this.updated_at,
      this.viator_destination_id,
      this.viator_destination_type,
      this.viator_iata_code,
      this.viator_lookup_id});
  factory Placesmodel.fromJson(Map<String, dynamic> data) =>
      _$PlacesmodelFromJson(data);
  Map<String, dynamic> toJson() => _$PlacesmodelToJson(this);
}
