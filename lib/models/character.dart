class Character{
  int? id;
  String? name;
  String? gender;
  String? image;
  String? status;
  List<String>? episodeUrl;

  Character({this.id, this.name, this.gender, this.image, this.status, this.episodeUrl});

  factory Character.fromJson(Map<String, dynamic> json){
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
      status: json['status'] as String,
      episodeUrl: (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }


}

class Episode{
  int? id;
  String? name;
  String? episode;

  Episode({this.id, this.name, this.episode});

  factory Episode.fromJson(Map<String, dynamic> json){
    return Episode(
      id: json['id'],
      name: json['name'],
      episode: json['episode'],
    );
  }
}

