import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  //

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }

  //
}

// Obtenez la hauteur proportionnée selon la taille de l'écran
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!;
  //812 est la hauteur de mise en page utilisée par le concepteur
  return (inputHeight / 812.0) * screenHeight;
}

// Obtenez la largeur proportionnée selon la taille de l'écran
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;
  //375 est la largeur de mise en page utilisée par le concepteur
  return (inputWidth / 375.0) * screenWidth;
}



class SizeHelper {
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _blockSizeHorizontal;
  static late double _blockSizeVertical;

  static void init(BuildContext context, {double designWidth = 375, double designHeight = 812}) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _blockSizeHorizontal = _screenWidth / designWidth;
    _blockSizeVertical = _screenHeight / designHeight;
  }

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
  static double get blockSizeHorizontal => _blockSizeHorizontal;
  static double get blockSizeVertical => _blockSizeVertical;

  static double width(double width) => width * _blockSizeHorizontal;
  static double height(double height) => height * _blockSizeVertical;
}

