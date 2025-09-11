import 'package:flutter/animation.dart';

class SizeConstants {
  SizeConstants._internal();

  static final SizeConstants _instance = SizeConstants._internal();

  factory SizeConstants() {
    return _instance;
  }

  ///main radius
  static const double fullBorderRadius = 40;
  static const double outerBorderRadius = 14;
  static const double innerBorderRadius = 10;
  static const double smallBorderRadius = 6;

  //used inside conatiners
  static const double smallInnerPadding = 8;
  static const double innerContainerPadding = 16;
  static const double superBigInnerContainerHorizontalPadding = 40;

  static const double horizontalPadding = 8;
  static const double verticalSpace = 15;

  static const int mainMilliSecondsDuration = 500;
  static const int mainMillisecondsSlideDuration = 700;

  static const duration = Duration(milliseconds: mainMillisecondsSlideDuration);
  static const durationSmall = Duration(milliseconds: mainMilliSecondsDuration);
  static const pageTransitionDelay = Duration(milliseconds: 200);
  static const delay = Duration(milliseconds: mainMillisecondsSlideDuration);
  static const delay2 = Duration(
    milliseconds: mainMillisecondsSlideDuration + 200,
  );
  static const delay3 = Duration(
    milliseconds: mainMillisecondsSlideDuration + 400,
  );
  static const mainCurve = Curves.fastOutSlowIn;
}
