import 'package:flutter/material.dart';
import 'package:moviefy/Screens/search_screen.dart';
import 'package:moviefy/Utilies/brand_name.dart';
import 'package:moviefy/Utilies/constants.dart';
import 'package:moviefy/Widgets/drawer.dart';
import 'file:///F:/applications_projects/moviefy/lib/Screens/body_screen.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    provider.loadMovies(provider.pageNumber);
    provider.loadGenres();

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
      body: BodyScreen(),
    );
  }
}
