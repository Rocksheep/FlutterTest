class Game {
  String _name;
  String _coverUrl;

  Game(String name, String coverUrl) {
    _name = name;
    _coverUrl = coverUrl;
  }

  String getName() {
    return _name;
  }

  String getCoverUrl() {
    return _coverUrl;
  }

  static Game fromJson(json) {
    var coverUrl = '';
    
    if (json['cover'] != null) {
      coverUrl = 'https://images.igdb.com/igdb/image/upload/t_cover_big/'+json['cover']['image_id']+'.jpg';
    }

    return Game(json['name'], coverUrl);
  }
}