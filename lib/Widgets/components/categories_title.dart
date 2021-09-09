import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryTitle extends StatelessWidget {
  final String title;

  CategoryTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 15),
        child: Text(
          title,
          style: GoogleFonts.muli(
              textStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
        ));
  }
}
