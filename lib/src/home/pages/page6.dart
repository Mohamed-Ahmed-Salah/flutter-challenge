
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/widgets/budget_slider.dart';
import 'package:flutter_challenge/src/home/widgets/page_sizer.dart';
import 'package:flutter_challenge/src/home/widgets/slider_section.dart';

class Page6 extends StatefulWidget {
  const Page6({super.key});

  @override
  State<Page6> createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  double brandPreference = 0.5; // 0.0 = Local, 1.0 = National
  double coverageDepth = 0.5; // 0.0 = Basic, 1.0 = Complex
  RangeValues _currentRangeValues = const RangeValues(800, 1200);

  @override
  Widget build(BuildContext context) {
    return PageSize(
      child: Padding(
        padding: EdgeInsets.all(SizeConstants.innerContainerPadding),
        child: Column(
          children: [
            SliderSection(
                  title: 'Brand Preference',
                  leftLabel: 'Local',
                  rightLabel: 'National',
                  value: brandPreference,
                  icon: Icons.business_outlined,
                  onChanged: (value) {
                    setState(() => brandPreference = value);
                    // _animateThumb();
                  },
                )
                .animate()
                .slideY(
                  curve: SizeConstants.mainCurve,
                  duration: SizeConstants.duration,
                  begin: 0.2,
                  delay: Duration(milliseconds: 300),
                )
                .fade(),
            SizedBox(height: SizeConstants.verticalSpace),
            SliderSection(
                  title: 'Coverage Depth',
                  leftLabel: 'Basic',
                  rightLabel: 'Complex',
                  value: coverageDepth,
                  icon: Icons.layers_outlined,
                  onChanged: (value) {
                    setState(() => coverageDepth = value);
                    // _animateThumb();
                  },
                )
                .animate()
                .slideY(
                  curve: SizeConstants.mainCurve,
                  duration: SizeConstants.duration,
                  begin: 0.2,
              delay: Duration(milliseconds: 400),
                )
                .fade(),
            SizedBox(height: SizeConstants.verticalSpace),
            BudgetSlider(
                  currentRangeValues: _currentRangeValues,
                  onChange: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                )
                .animate()
                .slideY(
                  curve: SizeConstants.mainCurve,
                  duration: SizeConstants.duration,
                  begin: 0.2,
              delay: Duration(milliseconds: 500),
                )
                .fade(),
            // _buildBudgetSlider(),
          ],
        ),
      ),
    );
  }
}
