import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviefy/Screens/movie_detail_screen.dart';
import 'package:moviefy/Widgets/components/star_widget.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class TrendingMovieCard extends StatefulWidget {
  final int pageNumber;

  TrendingMovieCard({this.pageNumber = 1});
  @override
  _TrendingMovieCardState createState() => _TrendingMovieCardState();
}

class _TrendingMovieCardState extends State<TrendingMovieCard> {
  int pageNumber;
  @override
  void initState() {
    pageNumber = widget.pageNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);

    return provider.trendingMoviesList == null
        ? CircularProgressIndicator()
        : Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            height: MediaQuery.of(context).size.height * 0.40,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, index) =>
                  VerticalDivider(
                color: Colors.transparent,
                width: 10,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == provider.trendingMoviesList.length)
                  return TextButton(
                      onPressed: () {
                        provider.pageNumber = pageNumber++;
                        provider.addTrendingMovie(pageNumber++);
                      },
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.yellowAccent,
                        size: 50,
                      ));
                else
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDetailPage(
                                      movie: provider.trendingMoviesList[index],
                                      index: index)));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/original/${provider.trendingMoviesList[index].backDropPath}',
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: 190,
                                height:
                                    MediaQuery.of(context).size.height * 0.30,
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
                              height: MediaQuery.of(context).size.height * 0.30,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 190,
                              height: MediaQuery.of(context).size.height * 0.30,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/notfound.jpg'),
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
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 5, top: 5),
                        width: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.trendingMoviesList[index].title,
                              style: GoogleFonts.muli(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            StarRate(
                              vote: provider
                                  .trendingMoviesList[index].voteAverage,
                            )
                          ],
                        ),
                      ),
                    ],
                  );
              },
              itemCount: provider.popularMoviesList.length + 1,
            ),
          );
  }
}
