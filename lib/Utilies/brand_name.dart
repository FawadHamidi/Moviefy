import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget BrandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Text(
      //   'MOVIE',
      //   style: GoogleFonts.muli(
      //       textStyle:
      //           TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      // ),
      // Text(
      //   'FY',
      //   style: GoogleFonts.rubik(
      //       textStyle: TextStyle(
      //     color: Colors.yellowAccent,
      //   )),
      // )
      Image.asset(
        'assets/images/moviefy.png',
        scale: 26,
      )
    ],
  );
}
