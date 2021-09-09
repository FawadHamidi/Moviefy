import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviefy/Screens/search_screen.dart';
import 'package:moviefy/Utilies/brand_name.dart';
import 'package:moviefy/Utilies/constants.dart';
import 'package:moviefy/Widgets/components/people_detail_row_components.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class PeopleDetailScreen extends StatelessWidget {
  final int id;

  PeopleDetailScreen({this.id});

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    var provider = Provider.of<ApiProvider>(context, listen: false);

    return FutureBuilder(
      future: provider.loadPeopleDetail(id),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done &&
            provider.peopleDetail != null)
          return Scaffold(
              backgroundColor: Constants.kBackgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Icon(Icons.menu),
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
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 4,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(500),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(500),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w200/${provider.peopleDetail.profilePath}',
                              imageBuilder: (context, imageBuilder) {
                                return Container(
                                  height: _height / 4,
                                  width: _height / 4,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(500),
                                    image: DecorationImage(
                                      image: imageBuilder,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              placeholder: (context, url) => Container(
                                  height: _height / 4,
                                  width: _height / 4,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              errorWidget: (context, url, error) => Container(
                                width: _height / 4,
                                height: _height / 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(500),
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
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.white.withOpacity(0.4),
                        indent: 60,
                        endIndent: 60,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          MyCustomRow(
                            text: 'Name',
                            desc: provider.peopleDetail.name,
                          ),
                          MyCustomRow(
                            text: 'gender',
                            desc: provider.peopleDetail.gender == 1
                                ? 'Female'
                                : 'male',
                          ),
                          MyCustomRow(
                              text: 'Known for',
                              desc: provider.peopleDetail.knownForDepartment),
                          MyCustomRow(
                              text: 'Birthday',
                              desc: provider.peopleDetail.birthday),
                          MyCustomRow(
                              text: 'Place of birth',
                              desc: provider.peopleDetail.placeOfBirth),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.black26.withOpacity(0.2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'Biography',
                                  style: GoogleFonts.muli(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.yellowAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.black26.withOpacity(0.2),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    provider.peopleDetail.biography,
                                    style: GoogleFonts.muli(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
