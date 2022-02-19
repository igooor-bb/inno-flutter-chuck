// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joke _$JokeFromJson(Map<String, dynamic> json) {
  return Joke(
    categories:
        (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
    iconUrl: json['icon_url'] as String,
    id: json['id'] as String,
    url: json['url'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$JokeToJson(Joke instance) => <String, dynamic>{
      'icon_url': instance.iconUrl,
      'categories': instance.categories,
      'id': instance.id,
      'url': instance.url,
      'value': instance.value,
    };

JokeSearch _$JokeSearchFromJson(Map<String, dynamic> json) {
  return JokeSearch(
    total: json['total'] as int,
    result: (json['result'] as List<dynamic>)
        .map((e) => Joke.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$JokeSearchToJson(JokeSearch instance) =>
    <String, dynamic>{
      'total': instance.total,
      'result': instance.result,
    };
