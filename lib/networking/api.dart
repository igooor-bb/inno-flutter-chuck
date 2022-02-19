import 'package:dio/dio.dart';
import '../models/joke.dart';
import "package:logger/logger.dart";

class ApiService {
  final Dio _dio = Dio();
  final _baseUrl = 'https://api.chucknorris.io/jokes';
  final logger = Logger(printer: PrettyPrinter());

  Future<List<Joke>> getRandomJoke(String? category) async {
    List<Joke> jokes = [];
    try {
      var url = _baseUrl + '/random';
      if (category != null) {
        url += '?category=$category';
      }
      Response jokesData = await _dio.get(url);
      jokes.add(Joke.fromJson(jokesData.data));
    } catch (e) {
      logger.e('Error occured while getting random joke: $e');
    }

    return jokes;
  }

  Future<List<Joke>> getJokes(String query, String? category) async {
    List<Joke> jokes = [];
    try {
      final url = _baseUrl + '/search?query=${Uri.encodeQueryComponent(query)}';
      Response jokesData = await _dio.get(url);
      jokes = JokeSearch.fromJson(jokesData.data).result;
      if (category != null) {
        jokes = jokes.where((element) {
          return element.categories.contains(category);
        }).toList();
      }
    } catch (e) {
      logger.e('Error occured while getting jokes using $query: $e');
    }

    return jokes;
  }

  Future<List<String>> getCategories() async {
    try {
      Response response = await _dio.get(_baseUrl + '/categories');

      return (response.data as List).map((e) => e as String).toList();
    } catch (e) {
      logger.e('Error occured while getting categories list: $e');
    }

    return [];
  }
}
