import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviefy/Models/movie_model.dart';
import 'package:moviefy/Screens/people_screen_view.dart';
import 'package:moviefy/Screens/screenshot_image_view.dart';
import 'package:moviefy/Utilies/constants.dart';
import 'package:moviefy/Widgets/favorite_icon.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  final int index;
  MovieDetailPage({this.movie, this.index});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    // provider.loadSearchMovie(movie.title);
    return FutureBuilder(
        future: provider.loadMovieDetail(movie.id),
        builder: (context, snap) {
          print('builder detaillll');
          if (snap.connectionState == ConnectionState.done &&
              provider.movieDetail != null)
            return WillPopScope(
              child: Scaffold(
                backgroundColor: Constants.kBackgroundColor,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipPath(
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original/${movie.backDropPath}',
                                height: MediaQuery.of(context).size.height / 2,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                    child: Center(
                                        child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) => Container(
                                    decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 10,
                                      spreadRadius: 10,
                                    )
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/notfound.jpg'),
                                  ),
                                )),
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 8),
                                child: GestureDetector(
                                  onTap: () async {
                                    provider.movieDetail.trailerId == "No link"
                                        ? Fluttertoast.showToast(
                                            textColor: Colors.yellow,
                                            backgroundColor: Colors.black,
                                            msg:
                                                "Sorry, no trailer link available",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                          )
                                        : await launch(
                                            'https://www.youtube.com/embed/${provider.movieDetail.trailerId}');
                                  },
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.play_arrow,
                                          color: Colors.yellowAccent,
                                          size: 65,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black26.withOpacity(0.5),
                                          ),
                                          child: Text(
                                            provider.movieDetail.title,
                                            style: GoogleFonts.muli(
                                                textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.black26.withOpacity(0.2),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    'Overview',
                                    style: GoogleFonts.muli(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.yellowAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                FavoriteIcon(
                                  movie,
                                ),
                                Flexible(
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    margin: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.yellowAccent,
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                          offset: Offset.zero,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          provider.movieDetail.voteAverage,
                                          style: GoogleFonts.muli(
                                              textStyle: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                provider.movieDetail.overview,
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Release Date:',
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                provider.movieDetail.releaseDate,
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                'RunTime:',
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                "${provider.movieDetail.runTime} Minutes",
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Budget:',
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                "${provider.movieDetail.budget}\$",
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Revenue:',
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                "${provider.movieDetail.revenue}\$",
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Status:',
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                "${provider.movieDetail.status}",
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black26.withOpacity(0.2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'CASTS',
                                  style: GoogleFonts.muli(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellowAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              height: 110,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      VerticalDivider(
                                        color: Colors.transparent,
                                        width: 5,
                                      ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PeopleDetailScreen(
                                                              id: provider
                                                                  .movieDetail
                                                                  .castList[
                                                                      index]
                                                                  .id)));
                                            },
                                            child: Card(
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              elevation: 3,
                                              child: ClipRRect(
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://image.tmdb.org/t/p/w200/${provider.movieDetail.castList[index].profilePath}',
                                                  imageBuilder:
                                                      (context, imageBuilder) {
                                                    return Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        image: DecorationImage(
                                                          image: imageBuilder,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          height: 80,
                                                          width: 80,
                                                          child: Center(
                                                              child:
                                                                  CircularProgressIndicator())),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/notfound.jpg'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    provider.movieDetail
                                                        .castList[index].name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.muli(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 8),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    provider
                                                        .movieDetail
                                                        .castList[index]
                                                        .character,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.muli(
                                                      textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 8),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount:
                                      provider.movieDetail.castList.length),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Screenshots',
                                style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.yellowAccent,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              height: 160,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    VerticalDivider(
                                  color: Colors.transparent,
                                  width: 5,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: provider
                                    .movieDetail.movieImage.backdrops.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  ImageView(index)));
                                    },
                                    child: Hero(
                                      tag: 'screenshot',
                                      child: Container(
                                        child: Card(
                                          color: Colors.transparent,
                                          elevation: 3,
                                          borderOnForeground: false,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${provider.movieDetail.movieImage.backdrops[index].imagePath}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onWillPop: () async => true,
            );
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
