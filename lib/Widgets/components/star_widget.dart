import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StarRate extends StatelessWidget {
  final String vote;

  StarRate({this.vote});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.yellowAccent,
          size: 18,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          vote,
          style: GoogleFonts.muli(
              textStyle: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ],
    );
  }
}
