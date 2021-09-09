import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomRow extends StatelessWidget {
  final String text;
  final String desc;

  MyCustomRow({this.text, this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black26.withOpacity(0.2),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Text(
              text,
              style: GoogleFonts.muli(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black26.withOpacity(0.2),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Text(
                desc,
                style: GoogleFonts.muli(
                  textStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
