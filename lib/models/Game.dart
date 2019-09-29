class Game {
  String _name;
  String _coverUrl;
  String _summary;

  Game(String name, String summary, String coverUrl) {
    _name = name;
    _coverUrl = coverUrl;
    _summary = summary;
  }

  String getName() {
    return _name;
  }

  String getCoverUrl() {
    return _coverUrl;
  }

  String getSummary() {
    return _summary;
  }

  static Game fromJson(json) {
    var coverUrl = '';
    
    if (json['cover'] != null) {
      coverUrl = 'https://images.igdb.com/igdb/image/upload/t_cover_big/'+json['cover']['image_id']+'.jpg';
    }

    return Game(json['name'], json['summary'], coverUrl);
  }
}