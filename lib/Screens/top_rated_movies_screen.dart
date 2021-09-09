import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviefy/Screens/movie_detail_screen.dart';
import 'package:moviefy/Screens/search_screen.dart';
import 'package:moviefy/Utilies/brand_name.dart';
import 'package:moviefy/Utilies/constants.dart';
import 'package:moviefy/Widgets/components/star_widget.dart';
import 'package:moviefy/Widgets/drawer.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class TopRatedMovieScreen extends StatefulWidget {
  @override
  _TopRatedMovieScreenState createState() => _TopRatedMovieScreenState();
}

class _TopRatedMovieScreenState extends State<TopRatedMovieScreen> {
  int pageNumber = 1;
  ScrollController _controller = ScrollController();
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        pageNumber++;
      });
      print('endscroll: $pageNumber');
    }
  }

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('builder: $pageNumber');
    var provider = Provider.of<ApiProvider>(context, listen: false);
    provider.pageNumber = pageNumber++;
    provider.addTopRated(pageNumber);
    return Scaffold(
      backgroundColor: Constants.kBackgroundColor,
      drawer: MyCustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: BrandName(),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 15),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                  child: Icon(Icons.search)))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
            controller: _controller,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 0.1,
                mainAxisExtent: 380),
            itemCount: provider.topRatedMoviesList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetailPage(
                                  movie: provider.topRatedMoviesList[index],
                                  index: index)));
                    },
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/original/${provider.topRatedMoviesList[index].posterPath}',
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: 190,
                              height: 300,
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
                            width: 190,
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 190,
                            height: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/notfound.jpg'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black26.withOpacity(0.2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 10, bottom: 5, top: 5),
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.topRatedMoviesList[index].title,
                          style: GoogleFonts.muli(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        StarRate(
                          vote: provider.topRatedMoviesList[index].voteAverage,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
