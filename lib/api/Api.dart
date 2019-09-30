import 'dart:convert' as convert;
import 'package:game_library/models/Game.dart';
import 'package:game_library/configs/api.dart' as ApiConfig;
import 'package:http/http.dart' as http;

class Api {
  String _baseUrl = 'api-v3.igdb.com';

  Future<http.Response> _get<T>(
    String endPoint, {
    Map<String, String> queryParameters,
  }) {
    final url = Uri.https(_baseUrl, endPoint, queryParameters);
    final response = http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'user-key': ApiConfig.IGDB_KEY
      },
    );

    return response;
  }

  Future<Game> getGame(int id) async {
    final response = await this._get(
      'games/1',
      queryParameters: {
        'fields': 'name,rating,popularity',
        'order': 'popularity desc'
      });
    
    return Game.fromJson(convert.jsonDecode(response.body)[0]);
  }

  Future<List<Game>> getPopularGames(int page) async {
    final limit = 10;
    final offset = (page - 1) * limit;

    final response = await this._get(
      'games',
      queryParameters: {
        'fields': 'name,rating,popularity,cover.image_id,summary',
        'order': 'popularity:desc',
        'limit': limit.toString(),
        'offset': offset.toString(),
        'filter[themes][not_eq]': '(42)',
      });
    
    List<Game> games = <Game>[];
    for (var game in convert.jsonDecode(response.body)) {
      games.add(Game.fromJson(game));
    }

    return games;
  }
}