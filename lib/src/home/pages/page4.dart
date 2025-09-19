import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/widgets/page_sizer.dart';

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  Set<String> selectedConditions1 = {};
  Set<String> selectedConditions2 = {};

  List<String> medicalConditions1 = [
    "💉 Diabetes",
    "👅 Thyroid",
    "🩸 Blood pressure",
    "🫁 Asthma",
    "🔪 Any surgery",
    "🦠 Other disease",
  ];

  List<String> medicalConditions2 = [
    "🫀 Organ surgery",
    "💅 Cosmetic",
    "🎗️ Cancer",
    "👶 Reproductive",
    "🧬 Substance",
    "🩼 Accident",
    "🚑 Other",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return PageSize(
      child: SizedBox(
        width: mediaQuery.size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 5,

              children: medicalConditions1.map((condition) {
                final isSelected = selectedConditions1.contains(condition);
                final index = medicalConditions1.indexOf(condition);

                // group every 2 items together
                final group = (index ~/ 2).toInt();

                final delay =
                    SizeConstants.small300MilliSecondsDuration + (group * 50);
                return FilterChip(
                      labelStyle: TextStyle(
                        color: isSelected ? Colours.primaryColor : null,
                      ),
                      label: Text(condition),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedConditions1.add(condition);
                          } else {
                            selectedConditions1.remove(condition);
                          }
                          if (selectedConditions1.isEmpty &&
                              controller.isCompleted) {
                            controller.reverse();
                          } else if (!controller.isCompleted) {
                            controller.forward();
                          }
                        });
                      },
                      selectedColor: Colours.whiteColor,
                      backgroundColor: Colours.whiteColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isSelected
                              ? Colours.primaryColor
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConstants.fullBorderRadius,
                        ),
                      ),
                      shadowColor: Colours.primaryColor,
                    )
                    .animate()
                    .slideY(
                      curve: SizeConstants.mainCurve,
                      duration: SizeConstants.duration,
                      begin: 0.2,
                      delay: Duration(milliseconds: delay),
                    )
                    .fade();
              }).toList(),
            ),

            Column(
              key: Key("more info condition"),
              children: [
                const SizedBox(height: SizeConstants.verticalSpace),
                Text(
                      "Tell us more",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey.shade600,
                      ),
                    )
                    .animate(controller: controller, autoPlay: false)
                    .slideY(
                      curve: SizeConstants.mainCurve,
                      duration: SizeConstants.duration,
                      begin: 0.2,
                      // delay: Duration(milliseconds: delay),
                    )
                    .fade(),
                const SizedBox(height: SizeConstants.verticalSpace),

                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 5,
                  children: medicalConditions2.map((condition) {
                    final isSelected = selectedConditions2.contains(condition);

                    final index = medicalConditions2.indexOf(condition);

                    // group every 2 items together
                    final group = index ~/ 2;

                    final delay =
                        SizeConstants.small300MilliSecondsDuration +
                        (group * 50);
                    return FilterChip(
                          labelStyle: TextStyle(
                            color: isSelected ? Colours.primaryColor : null,
                          ),
                          label: Text(condition),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedConditions2.add(condition);
                              } else {
                                selectedConditions2.remove(condition);
                              }
                            });
                          },
                          selectedColor: Colours.whiteColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: isSelected
                                  ? Colours.primaryColor
                                  : Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(
                              SizeConstants.fullBorderRadius,
                            ),
                          ),
                        )
                        .animate(controller: controller, autoPlay: false)
                        .slideY(
                          curve: SizeConstants.mainCurve,
                          duration: SizeConstants.duration,
                          begin: 0.2,
                          delay: Duration(milliseconds: delay),
                        )
                        .fadeIn();
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// "🩺 Diabetes",
// "🩸 Blood pressure",
// "🔪 Any surgery",
// "🫀 Organ Surgery",
// "🧬 Cancer",
// "💊 Substance",
// "🦷 Thyroid",
// "🫁 Asthma",
// "🟢 Other desire",
// "💄 Cosmetic",
// "🍼 Reproductive",
// "🚗 Accident",
// "🏥 Other",
