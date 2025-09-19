import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/widgets/CustomSliderThumbShape.dart';
import 'package:flutter_challenge/src/home/widgets/full_width_slider_shape.dart';
import 'package:flutter_challenge/src/home/widgets/page_sizer.dart';
import 'package:flutter_challenge/src/home/widgets/slider_box.dart';

class BudgetSlider extends StatelessWidget {
  final RangeValues currentRangeValues;
  final Function(RangeValues values) onChange;

  const BudgetSlider({
    super.key,
    required this.currentRangeValues,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliderBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Budget',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colours.textColor,
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6.0,
              activeTrackColor: Colours.primaryColor,
              inactiveTrackColor: Colours.primaryColor.withValues(alpha: 0.3),
              trackShape: FullWidthTrackShape(),
              rangeThumbShape: CustomRangeThumbShape(
                icon: Icons.monetization_on,
                thumbRadius: 20.0,
              ),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
              overlayColor: Colours.primaryColor.withValues(alpha: 0.4),
              showValueIndicator: ShowValueIndicator.alwaysVisible,
              valueIndicatorColor: Colors.transparent,
              valueIndicatorTextStyle: TextStyle(
                height: 1,
                color: Colours.textColor,
              ),
            ),
            child: RangeSlider(
              values: currentRangeValues,
              min: 500,
              max: 1500,
              divisions: 500,

              labels: RangeLabels(
                "\$${currentRangeValues.start.round().toString()}",
                "\$${currentRangeValues.end.round().toString()}",
              ),
              onChanged: onChange,
            ),
          ),
          SizedBox.shrink(),
        ],
      ),
    );
  }
}
