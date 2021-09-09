import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviefy/Utilies/constants.dart';
import 'package:moviefy/providers/provider.dart';
import 'package:provider/provider.dart';

class GenreList extends StatefulWidget {
  final int selectedGenre;

  GenreList({this.selectedGenre = 28});

  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {
  int selectedGenre;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedGenre = widget.selectedGenre;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, provider, child) {
        // print(provider.genreList);
        return provider.genreList == null
            ? CircularProgressIndicator()
            : Container(
                height: 40,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, index) =>
                      VerticalDivider(
                    color: Colors.transparent,
                    width: 5,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.genreList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedGenre = provider.genreList[index].id;
                        provider.loadMovieByGenre(
                            selectedGenre, provider.pageNumber);
                        print(selectedGenre);
                        provider.changeGenre(selectedGenre);
                      },
                      child: Container(
                        padding: EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          border: Border.all(color: Constants.kGenreBoxColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          color: (provider.genreList[index].id == selectedGenre)
                              ? Constants.kGenreBoxColor
                              : Constants.kBackgroundColor,
                        ),
                        child: Text(
                          provider.genreList[index].name.toUpperCase(),
                          style: GoogleFonts.muli(
                              textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                (provider.genreList[index].id == selectedGenre)
                                    ? Constants.kBackgroundColor
                                    : Constants.kGenreBoxColor,
                          )),
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
