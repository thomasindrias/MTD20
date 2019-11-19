import 'package:flutter/material.dart';

class AppTheme {
  static const TextStyle display1 = TextStyle(
    fontFamily: 'WorkSans',
    color: Colors.black87,
    fontSize: 38,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  static const TextStyle display2 = TextStyle(
    //fontFamily: 'WorkSans',
    color: Colors.black87,
    fontSize: 32,
    fontWeight: FontWeight.normal,
    //letterSpacing: 1.1,
  );

  static const TextStyle display3 = TextStyle(
    fontFamily: 'WorkSans',
    color: Colors.black87,
    fontSize: 28,
    fontWeight: FontWeight.normal,
    //letterSpacing: 1.1,
  );

  static const TextStyle displayBold = TextStyle(
    //fontFamily: 'WorkSans',
    color: Colors.black87,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    //letterSpacing: 1.0,
  );

  static final TextStyle heading = TextStyle(
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w900,
    fontSize: 34,
    color: Colors.white.withOpacity(0.8),
    letterSpacing: 1.2,
  );

  static final TextStyle subHeading = TextStyle(
    inherit: true,
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w500,
    fontSize: 24,
    color: Colors.white.withOpacity(0.8),
  );

  static final TextStyle articleTitleStyle = TextStyle(
    //fontFamily: 'WorkSans',
    color: Colors.black87,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle articleDescriptionStyle = TextStyle(
    //fontFamily: 'WorkSans',
    color: Colors.black87,
    fontSize: 20.0,
    //fontWeight: FontWeight.bold,
  );
}
