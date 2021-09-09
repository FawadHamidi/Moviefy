class Movie {
  final String backDropPath;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  var popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final int voteCount;
  var voteAverage;

  Movie(
      {this.backDropPath,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteCount,
      this.voteAverage});

  factory Movie.fromJson(dynamic json) {
    if (json == null) {
      return Movie();
    }
    return Movie(
      backDropPath: json['backdrop_path'],
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteCount: json['vote_count'],
      voteAverage: json['vote_average'].toString(),
    );
  }
}
