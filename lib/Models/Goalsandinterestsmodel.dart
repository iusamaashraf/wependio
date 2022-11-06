import 'package:json_annotation/json_annotation.dart';

part 'Goalsandinterestsmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Goalsandinterestsmodel {
  int? id;
  String? name, image, description, created_at, updated_at;
  Goalsandinterestsmodel(
      {this.name,
      this.updated_at,
      this.id,
      this.created_at,
      this.description,
      this.image});
  factory Goalsandinterestsmodel.fromJson(Map<String, dynamic> data) =>
      _$GoalsandinterestsmodelFromJson(data);
  Map<String, dynamic> toJson() => _$GoalsandinterestsmodelToJson(this);
}
