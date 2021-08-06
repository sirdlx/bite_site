import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
    // color: Colors.white54,
    // fontFamily: 'OpenSans',
    );

final kLabelStyle = TextStyle(
  // color: Colors.white,
  fontWeight: FontWeight.bold,
);

final kBoxDecorationStyle = BoxDecoration(
  border: Border.all(
    width: 1,
    color: Colors.black,
    style: BorderStyle.solid,
  ),
  color: Colors.white70,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kBoxDecorationStyleXXX = BoxDecoration(
  color: Color(0xFFFC3A3A),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
