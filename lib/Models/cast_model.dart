class CastList {
  final List<Cast> cast;

  CastList({this.cast});
}

class Cast {
  final int id;
  final String name;
  final String profilePath;
  final String character;

  Cast({this.id, this.name, this.profilePath, this.character});

  factory Cast.fromJson(dynamic json) {
    if (json == null) {
      return Cast();
    }
    return Cast(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
      character: json['character: '],
    );
  }
}
