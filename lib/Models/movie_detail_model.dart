import 'package:moviefy/Models/cast_model.dart';
import 'package:moviefy/Models/movie_image_model.dart';

class MovieDetail {
  final int id;
  final String title;
  final String backdropPath;
  final String budget;
  final String homePage;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final String runTime;
  final String voteAverage;
  final String voteCount;
  final String revenue;
  final String status;

  String trailerId;
  MovieImage movieImage;
  List<Cast> castList;

  MovieDetail(
      {this.id,
      this.title,
      this.backdropPath,
      this.budget,
      this.homePage,
      this.originalTitle,
      this.overview,
      this.releaseDate,
      this.runTime,
      this.voteAverage,
      this.voteCount,
      this.trailerId,
      this.revenue,
      this.status});

  factory MovieDetail.fromJson(dynamic json) {
    return MovieDetail(
      id: json['id'],
      title: json['title'],
      backdropPath: json['back_drop_path'],
      budget: json['budget'].toString(),
      homePage: json['home_page'],
      originalTitle: json['original_title'],
      releaseDate: json['release_date'],
      overview: json['overview'],
      runTime: json['runtime'].toString(),
      voteAverage: json['vote_average'].toString(),
      voteCount: json['vote_count'].toString(),
      revenue: json['revenue'].toString(),
      status: json['status'],
    );
  }
}
