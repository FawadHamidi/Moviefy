import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviefy/Screens/movie_detail_screen.dart';
import 'package:moviefy/Utilies/constants.dart';
import 'package:moviefy/Widgets/deleteAll_icon.dart';
import 'package:moviefy/Widgets/delete_icon.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    provider.loadQueries();

    // print(provider.favorite.title);
    return Consumer<ApiProvider>(builder: (context, provider, child) {
      return provider?.queryList?.isEmpty ?? true
          ? Scaffold(
              backgroundColor: Constants.kBackgroundColor,
              body: Center(
                child: Container(
                  width: 200,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No Favorites!',
                          style: GoogleFonts.muli(
                              textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.w500,
                          ))),
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Constants.kBackgroundColor,
              floatingActionButton: DeleteAll(),
              body: Container(
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
                                      movie: provider.queryList[index],
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
                                  'https://image.tmdb.org/t/p/original/${provider.queryList[index].backDropPath}',
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
                              errorWidget: (context, url, error) => Container(
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    provider.queryList[index].title == null
                                        ? 'null'
                                        : provider.queryList[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.muli(
                                        textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                                  ),
                                ),
                                Text(
                                  "Released: ${provider.queryList[index].releaseDate}",
                                  style: GoogleFonts.muli(
                                      textStyle: TextStyle(
                                          color: Colors.grey, fontSize: 10)),
                                ),
                                Text(
                                  "Language: ${provider.queryList[index].originalLanguage}",
                                  style: GoogleFonts.muli(
                                      textStyle: TextStyle(
                                          color: Colors.grey, fontSize: 10)),
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
                                      provider.queryList[index].voteAverage,
                                      style: GoogleFonts.muli(
                                          textStyle:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                DeleteIcon(
                                  index,
                                  onDelete: (int i) {
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: provider.queryList.length,
                ),
              ),
            );
    });
  }
}
