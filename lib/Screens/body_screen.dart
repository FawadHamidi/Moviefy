import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviefy/Screens/movie_detail_screen.dart';
import 'package:moviefy/Widgets/components/categories_title.dart';
import 'package:moviefy/Widgets/genre_listview.dart';
import 'package:moviefy/Widgets/movie_card.dart';
import 'package:moviefy/Widgets/people_card.dart';
import 'package:moviefy/Widgets/popular_movie_card.dart';
import 'package:moviefy/Widgets/top_rated_movies.dart';
import 'package:moviefy/Widgets/trending_movie_card.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class BodyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    provider.loadTrendingMovie(provider.pageNumber);
    provider.loadMovieByGenre(provider.genreId, provider.pageNumber);
    provider.loadPeople();
    provider.loadTopRated(provider.pageNumber);
    provider.loadPopularMovie(provider.pageNumber);
    return Consumer<ApiProvider>(builder: (context, provider, child) {
      print('builder');
      return provider.movieList == null
          ? Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                        itemCount: provider.movieList.length,
                        itemBuilder: (context, index, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailPage(
                                    movie: provider.movieList[index],
                                    index: index,
                                  ),
                                ),
                              );
                              // print(provider.movieList[index]);
                            },
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${provider.movieList[index].backDropPath}',
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/notfound.jpg'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.black26.withOpacity(0.4),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                      )),
                                  child: Text(
                                    provider.movieList[index].title
                                        .toUpperCase(),
                                    style: GoogleFonts.muli(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          pauseAutoPlayOnTouch: true,
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: GenreList(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CategoryTitle(
                        title: 'Movie By Genre',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MovieCard(),
                      CategoryTitle(
                        title: 'Trending People On This Week ',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PeopleCard(),
                      SizedBox(
                        height: 10,
                      ),
                      CategoryTitle(
                        title: 'Top Rated Movies',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TopRatedMovies(),
                      CategoryTitle(
                        title: 'Popular Movies',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PopularMovieCard(),
                      CategoryTitle(title: 'Trending Movies'),
                      SizedBox(
                        height: 10,
                      ),
                      TrendingMovieCard(),
                      SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   alignment: Alignment.center,
                      //   margin: EdgeInsets.only(left: 15),
                      //   child: Text(
                      //     'Developer : Fawad Hamidi',
                      //     style: GoogleFonts.muli(
                      //         textStyle: TextStyle(
                      //       color: Colors.grey,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 18,
                      //     )),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                    ],
                  ),
                ),
              );
            });
    });
  }
}
