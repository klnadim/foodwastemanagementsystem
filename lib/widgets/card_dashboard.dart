import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

singleCard(IconData icondata, String icontitle) {
      return Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        // borderOnForeground: true,
        color: Colors.white,
        semanticContainer: true,
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    
    clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icondata,
                color: Colors.black,
                size: 89.0,
              ),
              Text(
                icontitle,
                style: GoogleFonts.ptSans(
                    color: const Color(0xff000000),
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    }