import 'dart:math';

import 'package:dio/dio.dart';
import 'package:moviefy/Models/cast_model.dart';
import 'package:moviefy/Models/genre_model.dart';
import 'package:moviefy/Models/movie_detail_model.dart';
import 'package:moviefy/Models/movie_image_model.dart';
import 'package:moviefy/Models/movie_model.dart';
import 'package:moviefy/Models/people_model.dart';

import 'database_helper/database.dart';
import 'database_helper/service_locator.dart';

class ApiServices {
  Dio _dio = Dio();
  final String baseUrl = "https://api.themoviedb.org/3";
  final String apiKey = "681d5aaa91b059143f50e83e69e55130";

  Future<List<Movie>> getNowPlayingMovies(int pageNumber) async {
    try {
      final response = await _dio
          .get('$baseUrl/movie/now_playing?api_key=$apiKey&page=$pageNumber');
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((e) => Movie.fromJson(e)).toList();
      return movieList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<List<Genre>> getGenres() async {
    try {
      final response =
          await _dio.get('$baseUrl/genre/movie/list?api_key=$apiKey');
      var genres = response.data['genres'] as List;
      List<Genre> genreList = genres.map((m) => Genre.fromJson(m)).toList();
      return genreList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<List<Movie>> getMovieByGenre(int genreId, int pageNumber) async {
    try {
      // print('adf $genreId');
      final response = await _dio.get(
          '$baseUrl/discover/movie?with_genres=$genreId&api_key=$apiKey&page=$pageNumber');
      var movies = response.data['results'] as List;
      List<Movie> movieByGenreList =
          movies.map((e) => Movie.fromJson(e)).toList();
      return movieByGenreList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<List<Movie>> getSearchMovie(String movieName) async {
    try {
      final response = await _dio
          .get('$baseUrl/search/movie?api_key=$apiKey&query=$movieName');
      var movies = response.data['results'] as List;
      List<Movie> searchMovieList =
          movies.map((e) => Movie.fromJson(e)).toList();
      // print(searchMovieList.length);
      return searchMovieList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<List<Movie>> getPopularMovies(int pageNumber) async {
    try {
      final response = await _dio
          .get('$baseUrl/movie/popular?api_key=$apiKey&page=$pageNumber');
      var popMovies = response.data['results'] as List;
      List<Movie> popularMoviesList =
          popMovies.map((e) => Movie.fromJson(e)).toList();
      // print(popularMoviesList[0].title);
      return popularMoviesList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<List<Movie>> getTopRatedMovies(int pageNumber) async {
    try {
      final response = await _dio
          .get('$baseUrl/movie/top_rated?api_key=$apiKey&page=$pageNumber');
      var ratedMovies = response.data['results'] as List;
      List<Movie> topRatedMoviesList =
          ratedMovies.map((e) => Movie.fromJson(e)).toList();
      print(topRatedMoviesList[0].releaseDate);
      return topRatedMoviesList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<List<Movie>> getTrendingMovies(int pageNumber) async {
    try {
      final response = await _dio
          .get('$baseUrl/trending/movie/day?api_key=$apiKey&page=$pageNumber');
      var trendMovies = response.data['results'] as List;
      List<Movie> trendingMoviesList =
          trendMovies.map((e) => Movie.fromJson(e)).toList();
      // print(popularMoviesList[0].title);
      return trendingMoviesList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<List<People>> getPeople() async {
    try {
      final response =
          await _dio.get('$baseUrl/trending/person/week?&api_key=$apiKey');
      var people = response.data['results'] as List;
      List<People> peopleList = people.map((p) => People.fromJson(p)).toList();
      return peopleList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<People> getPeopleDetail(int id) async {
    try {
      final response = await _dio.get('$baseUrl/person/$id?&api_key=$apiKey');
      // var people = response.data['results'] as List;
      People peopleDetail = People.fromJson(response.data);
      return peopleDetail;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final response =
          await _dio.get('$baseUrl/movie/$movieId?&api_key=$apiKey');
      MovieDetail movieDetail = MovieDetail.fromJson(response.data);
      movieDetail.trailerId = await getYoutubeId(movieId);
      movieDetail.movieImage = await getMovieImage(movieId);
      movieDetail.castList = await getCastList(movieId);
      // print(movieDetail.trailerId);
      return movieDetail;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<Movie> favoriteMovies(int movieId) async {
    try {
      final response =
          await _dio.get('$baseUrl/movie/$movieId?&api_key=$apiKey');
      Movie favoriteMovie = Movie.fromJson(response.data);
      // var movies = response.data['results'] as List;
      // List<Movie> movieList = movies.map((e) => Movie.fromJson(e)).toList();
      // print(response.data);
      return favoriteMovie;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<String> getYoutubeId(int id) async {
    try {
      final response =
          await _dio.get('$baseUrl/movie/$id/videos?&api_key=$apiKey');
      print((response.data['results'] as List).isEmpty);
      if ((response.data['results'] as List).isEmpty == true) {
        return "No link";
      } else {
        var youtubeId = response.data['results'][0]['key'];
        return youtubeId;
      }
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<MovieImage> getMovieImage(int id) async {
    try {
      final response =
          await _dio.get('$baseUrl/movie/$id/images?&api_key=$apiKey');
      return MovieImage.fromJson(response.data);
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<List<Cast>> getCastList(int id) async {
    try {
      final response =
          await _dio.get('$baseUrl/movie/$id/credits?&api_key=$apiKey');
      var list = response.data['cast'] as List;
      List<Cast> castList = list
          .map(
            (e) => Cast(
              id: e['id'],
              name: e['name'],
              profilePath: e['profile_path'],
              character: e['character'],
            ),
          )
          .toList();
      return castList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  // databse Services
  Future<List<Movie>> getDatabaseQueries() async {
    try {
      List<Map> queries = await locator<DatabaseHelper>().queryAll();
      List<Movie> movies = queries
          .map((e) => Movie.fromJson({
                'id': e['movieID'],
                'title': e['title'],
                'release_date': e['releaseDate'],
                'vote_average': e['vote'],
                'backdrop_path': e['backdropPath'],
                'original_language': e['language']
              }))
          .toList();
      print(movies);
      return movies;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }
}
