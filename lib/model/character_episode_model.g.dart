// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_episode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterEpisodeModel _$CharacterEpisodeModelFromJson(
        Map<String, dynamic> json) =>
    CharacterEpisodeModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      airDate: json['airDate'] as String?,
      episode: json['episode'] as String?,
      characters: (json['characters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      url: json['url'] as String?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$CharacterEpisodeModelToJson(
        CharacterEpisodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'airDate': instance.airDate,
      'episode': instance.episode,
      'characters': instance.characters,
      'url': instance.url,
      'created': instance.created,
    };
