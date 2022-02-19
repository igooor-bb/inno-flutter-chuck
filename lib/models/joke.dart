import 'package:json_annotation/json_annotation.dart';

part 'joke.g.dart';

@JsonSerializable()
class Joke {
  Joke({
    required this.categories,
    required this.iconUrl,
    required this.id,
    required this.url,
    required this.value,
  });

  @JsonKey(name: 'icon_url')
  String iconUrl;
  List<String> categories;
  String id;
  String url;
  String value;

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);
  Map<String, dynamic> toJson() => _$JokeToJson(this);
}

@JsonSerializable()
class JokeSearch {
  JokeSearch({required this.total, required this.result});

  int total;
  List<Joke> result;

  factory JokeSearch.fromJson(Map<String, dynamic> json) =>
      _$JokeSearchFromJson(json);
  Map<String, dynamic> toJson() => _$JokeSearchToJson(this);
}
