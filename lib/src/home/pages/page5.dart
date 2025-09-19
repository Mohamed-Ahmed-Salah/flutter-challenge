import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/widgets/page_sizer.dart';

class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  List<String> insuranceOptions = [
    "Doctor Visits",
    "Hospitalization",
    "Prescription",
    "Dental",
    "Vision",
    "Maternity",
    "Mental",
    "Emergency",
    "Vaccinations",
    "Lab Work",
    "Rehabilitation",
    "Chronic Illness",
    "Travel",
    "Wellness Program",
    "Low Deductibles",
    "Private Room",
    "Family",
    "Benefits",
    "Data Security",
  ];

  Set<String> selectedOptions = {};

  int getDelay(int index) {
    final group = index ~/ 3; // group every 2 items
    return SizeConstants.small300MilliSecondsDuration +
        ((group) * 50); // group 0 => 0 delay, then +50
  }

  @override
  Widget build(BuildContext context) {
    return PageSize(

      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.9,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 5,
          children: insuranceOptions.map((option) {
            final isSelected = selectedOptions.contains(option);
            final index = insuranceOptions.indexOf(option);
            final delay = getDelay(index);

            return FilterChip(
                  shadowColor: isSelected
                      ? Colours.primaryColor
                      : Colors.transparent,
                  surfaceTintColor: Colours.primaryColor,
                  labelStyle: TextStyle(
                    color: isSelected ? Colours.primaryColor : null,
                  ),
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedOptions.add(option);
                      } else {
                        selectedOptions.remove(option);
                      }
                    });
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isSelected
                          ? Colours.primaryColor
                          : Colors.grey.shade300,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(
                      SizeConstants.smallBorderRadius,
                    ),
                  ),
                )
                .animate()
                .slideY(
                  curve: SizeConstants.mainCurve,
                  duration: SizeConstants.duration,
                  begin: 0.2,
                  delay: Duration(milliseconds: delay),
                )
                .fadeIn();
          }).toList(),
        ),
      ),
    );
  }
}
