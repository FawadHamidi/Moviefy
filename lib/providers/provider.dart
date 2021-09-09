import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moviefy/Models/genre_model.dart';
import 'package:moviefy/Models/movie_detail_model.dart';
import 'package:moviefy/Models/movie_model.dart';
import 'package:moviefy/Models/people_model.dart';
import 'package:moviefy/Services/api_services.dart';
import 'package:moviefy/Services/database_helper/database.dart';

class ApiProvider extends ChangeNotifier {
  List<Movie> movieList;
  List<Genre> genreList;
  List<Movie> movieByGenreList;
  List<People> peopleList;
  MovieDetail movieDetail;
  List<Movie> popularMoviesList;
  List<Movie> trendingMoviesList;
  List<Movie> searchMovieList;
  List<Movie> topRatedMoviesList;
  Movie favorite;
  int genreId = 28;
  int movieId;
  String movieName;
  int pageNumber = 1;
  People peopleDetail;
  IconData icon = Icons.favorite_border;
  List<Movie> queryList;

  changeGenre(int id) {
    genreId = id;
    notifyListeners();
  }

  updateUI(int id) {
    pageNumber = id;
    notifyListeners();
  }

  loadMovies(int pageNumber) async {
    try {
      movieList = await ApiServices().getNowPlayingMovies(pageNumber);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  loadFavoriteMovies(int movieId) async {
    try {
      favorite = await ApiServices().favoriteMovies(movieId);
      notifyListeners();
      print(favorite.title);
      return favorite;
    } catch (e) {
      print(e);
    }
  }

  addMovies(int pageNumber) async {
    try {
      movieList += await ApiServices().getNowPlayingMovies(pageNumber);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  loadGenres() async {
    try {
      genreList = await ApiServices().getGenres();
      // print(genreList[0].id);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addMovieByGenre(int genreId, int pageNumber) async {
    try {
      movieByGenreList +=
          await ApiServices().getMovieByGenre(genreId, pageNumber);
      print(pageNumber);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  loadMovieByGenre(int genreId, int pageNumber) async {
    print('load $genreId');
    try {
      movieByGenreList =
          await ApiServices().getMovieByGenre(genreId, pageNumber);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  loadSearchMovie(String movieName) async {
    try {
      searchMovieList = await ApiServices().getSearchMovie(movieName);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  loadPopularMovie(int pageNumber) async {
    try {
      popularMoviesList = await ApiServices().getPopularMovies(pageNumber);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addPopularMovie(int pageNumber) async {
    try {
      popularMoviesList += await ApiServices().getPopularMovies(pageNumber);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  loadTopRated(int pageNumber) async {
    try {
      topRatedMoviesList = await ApiServices().getTopRatedMovies(pageNumber);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addTopRated(int pageNumber) async {
    try {
      topRatedMoviesList += await ApiServices().getTopRatedMovies(pageNumber);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  loadTrendingMovie(int pageNumber) async {
    try {
      trendingMoviesList = await ApiServices().getTrendingMovies(pageNumber);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addTrendingMovie(int pageNumber) async {
    try {
      trendingMoviesList += await ApiServices().getTrendingMovies(pageNumber);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  loadPeople() async {
    try {
      peopleList = await ApiServices().getPeople();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  loadPeopleDetail(int id) async {
    try {
      peopleDetail = await ApiServices().getPeopleDetail(id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  loadMovieDetail(int movieId) async {
    try {
      movieDetail = await ApiServices().getMovieDetail(movieId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // database providers
  IconData updateFav(bool isFav) {
    if (isFav) {
      icon = Icons.favorite;
    } else
      icon = Icons.favorite_border;
    notifyListeners();
    return icon;
  }

  loadQueries() async {
    try {
      queryList = await ApiServices().getDatabaseQueries();
      notifyListeners();
      print(queryList.length);
      // print(queryList[0].id);
      return queryList;
    } catch (e) {
      print(e);
    }
  }

  checkFavorites(int id) async {
    try {
      bool isFavorite = await DatabaseHelper().isFavourite(id);
      notifyListeners();
      return isFavorite;
    } catch (e) {
      print(e);
    }
  }
  deleteAllQueries() async {
    try {
      await DatabaseHelper().deleteAll();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
