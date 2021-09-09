import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviefy/Screens/movie_detail_screen.dart';
import 'package:moviefy/Utilies/brand_name.dart';
import 'package:moviefy/Utilies/constants.dart';
import 'package:moviefy/Widgets/drawer.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(builder: (context, provider, child) {
      print('7777777builder');
      return Scaffold(
        backgroundColor: Constants.kBackgroundColor,
        drawer: MyCustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: BrandName(),
          actions: [
            Icon(
              Icons.movie,
              color: Colors.transparent,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xfff5f8fd),
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onSubmitted: (val) async {
                            val = searchController.text;
                            await provider.loadSearchMovie(val);
                            // provider.movieName = val;
                            // provider.loadSearchMovie(val);
                            // print(provider.searchMovieList[0].releaseDate);
                            // print(provider.searchMovieList[1].releaseDate);
                            // print(provider.searchMovieList[0].overview);
                            // print(provider.searchMovieList.length);

                            // searchController.clear();
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                              labelText: 'Search', border: InputBorder.none),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await provider.loadSearchMovie(searchController.text);
                        },
                        child: Container(
                          child: Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                provider.searchMovieList == null
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(
                          right: 15,
                          left: 15,
                          top: 15,
                        ),
                        height: MediaQuery.of(context).size.height,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            height: 10,
                            color: Colors.transparent,
                          ),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MovieDetailPage(
                                              movie: provider
                                                  .searchMovieList[index],
                                              index: index,
                                            )));
                              },
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original/${provider.searchMovieList[index].backDropPath}',
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          width: 150,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              )),
                                        );
                                      },
                                      placeholder: (context, url) => Container(
                                        width: 150,
                                        height: 150,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/notfound.jpg'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            provider
                                                .searchMovieList[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.muli(
                                                textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            )),
                                          ),
                                        ),
                                        Text(
                                          "Released: ${provider.searchMovieList[index].releaseDate}",
                                          style: GoogleFonts.muli(
                                              textStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10)),
                                        ),
                                        Text(
                                          "Language: ${provider.searchMovieList[index].originalLanguage}",
                                          style: GoogleFonts.muli(
                                              textStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10)),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellowAccent,
                                              size: 14,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              provider.searchMovieList[index]
                                                  .voteAverage,
                                              style: GoogleFonts.muli(
                                                  textStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: provider.searchMovieList.length,
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
