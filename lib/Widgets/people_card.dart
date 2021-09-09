import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviefy/Screens/people_screen_view.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class PeopleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    // provider.loadPeople();
    return provider.peopleList == null
        ? CircularProgressIndicator()
        : Container(
            padding: EdgeInsets.only(left: 10),
            height: 110,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => VerticalDivider(
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
                                    builder: (ctx) => PeopleDetailScreen(
                                          id: provider.peopleList[index].id,
                                        )));
                          },
                          child: Card(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            elevation: 3,
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w200/${provider.peopleList[index].profilePath}',
                                imageBuilder: (context, imageBuilder) {
                                  return Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                        image: imageBuilder,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                placeholder: (context, url) => Container(
                                    height: 80,
                                    width: 80,
                                    child: Center(
                                        child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) => Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
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
                        Container(
                          child: Center(
                            child: Text(
                              provider.peopleList[index].name,
                              style: GoogleFonts.muli(
                                textStyle:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              provider.peopleList[index].knownForDepartment,
                              style: GoogleFonts.muli(
                                textStyle:
                                    TextStyle(color: Colors.grey, fontSize: 8),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: provider.peopleList.length),
          );
  }
}
