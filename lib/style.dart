import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:admin/constant.dart';

class StyleText {
  TextStyle primaryStyle = const TextStyle(
    color: mblack,
    fontSize: 16,
  );
  TextStyle secondStyle = const TextStyle(
    color: mwhite,
    fontSize: 16,
  );
  TextStyle greyStyle = const TextStyle(
    color: mgrey,
    fontSize: 16,
  );
  TextStyle authStyle = const TextStyle(
    color: mColor5,
    fontSize: 16,
  );

  //font google
  TextStyle primaryFont = GoogleFonts.acme(
    color: mblack,
    fontSize: 16,
  );
  TextStyle greyFont = GoogleFonts.abel(
    color: mgrey[500],
    fontSize: 16,
  );
  TextStyle tabFont = GoogleFonts.aBeeZee(
    color: mblack,
    // fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  TextStyle minime = GoogleFonts.abel(
    color: mblack,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  var blackText = GoogleFonts.aBeeZee(
  color: mblack,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

var whiteText = GoogleFonts.aBeeZee(
  color: Colors.white,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

var whiteTextSmall = GoogleFonts.aBeeZee(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

var transStyle = GoogleFonts.aBeeZee(
  color: mblack,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

var noneStyle = GoogleFonts.aBeeZee(
  color: mblack,
);

var googleTitre = GoogleFonts.aBeeZee(
  fontSize: 16,
  color: mblack,
);
}

