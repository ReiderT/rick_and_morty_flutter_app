import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'character_episode_model.g.dart'; // Archivo generado para JSON serialization

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class CharacterEpisodeModel {
  int id;
  String? name; // Puede ser nulo
  String? airDate; // Puede ser nulo
  String? episode; // Puede ser nulo
  List<String>? characters; // Puede ser nulo
  String? url; // Puede ser nulo
  String? created; // Puede ser nulo

  CharacterEpisodeModel({
    required this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
    this.created,
  });

  factory CharacterEpisodeModel.fromJson(Map<String, dynamic> json) => _$CharacterEpisodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterEpisodeModelToJson(this);
}