import 'package:flutter/material.dart';
import 'package:game_library/models/Game.dart';

class GameDetails extends StatelessWidget {
  Game _game;

  GameDetails({ Key key, Game game }): super(key: key) {
    _game = game;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_game.getName())),
      body: Column(
        children: <Widget>[
          Image(
            fit: BoxFit.fitWidth,
            image: NetworkImage(_game.getCoverUrl()),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    _game.getName(),
                    style: TextStyle(fontSize: 24)
                  ),
                ),
                Text(
                  _game.getSummary(),
                  style: TextStyle(fontSize: 16)
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}