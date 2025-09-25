
import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/src/home/widgets/CustomSliderThumbShape.dart';
import 'package:flutter_challenge/src/home/widgets/full_width_slider_shape.dart';
import 'package:flutter_challenge/src/home/widgets/slider_box.dart';

class SliderSection extends StatelessWidget {
  final String title;
  final String leftLabel;
  final String rightLabel;
  final double value;
  final IconData icon;
  final ValueChanged<double> onChanged;

  const SliderSection({
    super.key,

    required this.title,
    required this.leftLabel,
    required this.rightLabel,
    required this.value,
    required this.icon,
    required this.onChanged,
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
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colours.textColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leftLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colours.hintColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                rightLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colours.hintColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6.0,
              activeTrackColor: Colours.primaryColor,
              inactiveTrackColor: Colours.primaryColor.withValues(alpha: 0.3),
              trackShape: FullWidthTrackShape(),
              thumbShape: CustomThumbShape(icon: icon, thumbRadius: 20.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
              overlayColor: Colours.primaryColor.withValues(alpha: 0.4),
              // trackShape: RoundedRectSliderTrackShape(),
            ),
            child: Slider(value: value, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}
