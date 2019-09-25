import 'package:game_library/api/Api.dart';
import 'package:game_library/models/Game.dart';

class GameRepository {
  final Api _api;

  const GameRepository(this._api);

  Future<Game> getGame(int id) {
    return _api.getGame(id);
  }

  Future<List<Game>> getPopularGames(int page) {
    return _api.getPopularGames(page);
  }
}