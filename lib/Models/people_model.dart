class People {
  final int id;
  final int gender;
  final String name;
  final String profilePath;
  final String knownForDepartment;
  final String popularity;
  final String birthday;
  final String biography;
  final String placeOfBirth;
  People(
      {this.id,
      this.gender,
      this.name,
      this.profilePath,
      this.knownForDepartment,
      this.popularity,
      this.birthday,
      this.biography,
      this.placeOfBirth});

  factory People.fromJson(dynamic json) {
    if (json == null) {
      return People();
    }
    return People(
      id: json['id'],
      gender: json['gender'],
      name: json['name'],
      profilePath: json['profile_path'],
      knownForDepartment: json['known_for_department'],
      popularity: json['popularity'].toString(),
      biography: json['biography'].toString(),
      birthday: json['birthday'].toString(),
      placeOfBirth: json['place_of_birth'].toString(),
    );
  }
}
