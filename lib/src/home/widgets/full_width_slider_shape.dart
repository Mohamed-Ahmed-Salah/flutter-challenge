import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/widgets/page_sizer.dart';
class FullWidthTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight!;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
