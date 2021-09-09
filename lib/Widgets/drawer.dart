import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviefy/Screens/favorite_screen.dart';
import 'package:moviefy/Screens/genre_list_screen.dart';
import 'package:moviefy/Screens/new_movies_screen.dart';
import 'package:moviefy/Screens/search_screen.dart';
import 'package:moviefy/Screens/top_rated_movies_screen.dart';
import 'package:moviefy/Utilies/constants.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCustomDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);

    return Drawer(
      child: Material(
        color: Constants.kBackgroundColor,
        child: Padding(
          padding: padding,
          child: ListView(
            children: [
              const SizedBox(
                height: 48,
              ),
              menuItem(
                  text: 'New Playing Movies',
                  onClick: () => selectedItem(context, 0)),
              Divider(
                height: 5,
                color: Colors.grey.withOpacity(0.5),
                indent: 10,
                endIndent: 10,
              ),
              menuItem(
                  text: 'Top Rated Movies',
                  onClick: () => selectedItem(context, 1)),
              Divider(
                height: 5,
                color: Colors.grey.withOpacity(0.5),
                indent: 10,
                endIndent: 10,
              ),
              ExpansionTile(
                childrenPadding: EdgeInsets.only(left: 20),
                iconColor: Colors.blue,
                collapsedIconColor: Colors.white,
                title: Text('Genres',
                    style: GoogleFonts.muli(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
                children: [
                  ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: provider.genreList.length,
                    itemBuilder: (context, index) {
                      return menuItem(
                          color: Colors.grey,
                          fontSize: 14,
                          text: provider.genreList[index].name,
                          onClick: () {
                            selectedItem(
                                context, 3, provider.genreList[index].id);
                          });
                    },
                  )
                ],
              ),
              Divider(
                height: 5,
                color: Colors.grey.withOpacity(0.5),
                indent: 10,
                endIndent: 10,
              ),
              menuItem(
                  text: 'Favorites',
                  onClick: () => selectedItem(
                        context,
                        2,
                      )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.6,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Developed by Artify Team \n Version: 1.0.0',
                            style: TextStyle(
                                fontFamily: 'Frutiger',
                                color: Colors.grey.withOpacity(0.6),
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Image.asset(
                      'assets/images/tmdb.png',
                      scale: 2,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: _tmdbURL,
                        child: Text.rich(
                          TextSpan(
                            text: 'Data by ',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'TMDB',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.grey)),
                              // can add more TextSpans here...
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _tmdbURL() async {
    const url = 'https://www.themoviedb.org/';

    await launch(url);
  }
}

Widget menuItem({
  String text,
  VoidCallback onClick,
  Color color = Colors.white,
  double fontSize = 16,
}) {
  return ListTile(
    title: Text(text,
        style: GoogleFonts.muli(
            textStyle: TextStyle(
                color: color,
                fontSize: fontSize,
                fontWeight: FontWeight.bold))),
    onTap: onClick,
  );
}

selectedItem(BuildContext context, int index, [int genreId]) {
  Navigator.of(context).pop();
  switch (index) {
    case 0:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewMoviesScreen()));
      break;
    case 1:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TopRatedMovieScreen()));
      break;
    case 2:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Favorites()));
      break;
    case 3:
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GenreScreen(
                    genreId: genreId,
                  )));
      break;
  }
}
