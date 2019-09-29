import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_library/api/Api.dart';
import 'package:game_library/models/Game.dart';
import 'package:game_library/pages/GameDetails.dart';
import 'package:game_library/repositories/GameRepository.dart';

class GameListState extends State<GameListWidget> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  GameRepository _repository;
  int _page = 1;
  List<Game> _loadedGames = [];
  bool _canLoad = true;

  GameListState() {
    _repository = GameRepository(Api());
    getGames();

    // dirty inline function
    _scrollController.addListener(() async {
        final isEnd = _scrollController.offset == _scrollController.position.maxScrollExtent;

        if (isEnd && _canLoad) {
          _page += 1;
          setState(() {
            _canLoad = false;
          });
          await getGames();
          setState(() {
            _canLoad = true;
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: _buildGrid()),
        Visibility(
          visible: !_canLoad,
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

  getGames() async {
    print('getting games');
    final games = await _repository.getPopularGames(_page);

    List<Game> tempGames = List<Game>.from(_loadedGames);
    tempGames.addAll(games);
    
    setState(() {
      _loadedGames = tempGames;
    });
    print(_loadedGames.length);
  }

  Widget _buildGrid() {
    return GridView.builder(
      itemCount: _loadedGames.length,
      controller: _scrollController,
      itemBuilder: (context, i) {
        return _buildGridItem(_loadedGames[i]);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.6,
        crossAxisCount: 2
      ),
    );
  }

  Widget _buildGridItem(Game game) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GameDetails(game: game))
        );
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Image(
              fit: BoxFit.fitWidth,
              image: NetworkImage(game.getCoverUrl()),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                game.getName(),
                style: _biggerFont,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GameListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GameListState();
}

class GameList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular games'),
      ),
      body: GameListWidget(),
    );
  }
}