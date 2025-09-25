import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/enums.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/controllers/page_controller.dart';
import 'package:flutter_challenge/src/home/widgets/custom_animated_sqitcher.dart';

class BackNextButton extends StatelessWidget {
  final PageSataProvider controller;
  final Animation<int> counter;

  const BackNextButton({
    super.key,
    required this.controller,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    final duration = const Duration(
      milliseconds: SizeConstants.mainMilliSecondsDuration,
    );
    final double containerButtonHeight = 50;
    final theme = Theme.of(context);
    return Positioned(
          bottom: 20,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final showBackButton = controller.currentPage == PageState.next;
              // true;
              // controller.currentPage != PageState.letsGetStarted &&
              //     controller.currentPage != PageState.seeResult &&
              //     controller.currentPage != PageState.analysing &&
              //     controller.currentIndex != 5;
              final availableWidth = constraints.maxWidth;
              // final showBackButton =
              //     controller.currentPage != PageState.letsGetStarted;

              // Calculate dynamic widths based on available space
              final buttonSpacing = SizeConstants.horizontalPadding;
              final backButtonWidth = showBackButton
                  ? _calculateTextWidth("Back", theme) +
                        (SizeConstants.superBigInnerContainerHorizontalPadding *
                            2)
                  : 0.0;
              final nextButtonText = controller.currentPage.toString();
              final nextButtonWidth =
                  _calculateTextWidth(nextButtonText, theme) +
                  (SizeConstants.superBigInnerContainerHorizontalPadding * 2);
              // Ensure buttons fit within available width
              final totalUsedWidth =
                  backButtonWidth + nextButtonWidth + buttonSpacing;
              final scaleFactor = totalUsedWidth > availableWidth
                  ? availableWidth / totalUsedWidth
                  : 1.0;
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: showBackButton ? 130 : 0,
                      height: showBackButton ? containerButtonHeight : 0,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: showBackButton ? 1.0 : 0.0,
                        child: GestureDetector(
                          key: Key("Back Button Animation"),
                          onTap: () {
                            controller.back();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: SizeConstants.horizontalPadding,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                SizeConstants.fullBorderRadius,
                              ),
                              color: Colours.whiteColor,
                            ),
                            child: Center(
                              child: Text(
                                key: ValueKey('${controller.currentPage}_back'),
                                "Back",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: duration,
                      curve: Curves.easeInOutCubic,
                      width: nextButtonWidth * scaleFactor,
                      height: containerButtonHeight,
                      child: InkWell(
                        onTap: () => controller.next(),
                        borderRadius: BorderRadius.circular(
                          SizeConstants.fullBorderRadius,
                        ),
                        child: AnimatedContainer(
                          duration: duration,
                          curve: Curves.easeInOutCubic,
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(
                              SizeConstants.fullBorderRadius,
                            ),
                          ),
                          child: Center(
                            child: AnimatedBuilder(
                              animation: counter,
                              builder: (context, child) {
                                return CustomAnimatedSwitcher(
                                  child: Text(
                                    controller.currentPage ==
                                            PageState.analysing
                                        ? "${controller.currentPage.text} ${counter.value}"
                                        : controller.currentPage.text,
                                    key: ValueKey(
                                      '${controller.currentPage}_text',
                                    ),
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(color: Colours.whiteColor),
                                  ),
                                  // AnimatedBuilder(
                                  //   animation: counter,
                                  //   builder: (context, child) {
                                  //     return Text(
                                  //       controller.currentPage ==
                                  //               PageState.analysing
                                  //           ? "${controller.currentPage.text} ${counter.value}"
                                  //           : controller.currentPage.text,
                                  //       key: ValueKey(
                                  //         '${controller.currentPage}_text',
                                  //       ),
                                  //       style: theme.textTheme.titleMedium
                                  //           ?.copyWith(color: Colours.whiteColor),
                                  //     );
                                  //
                                  //     // return Text(
                                  //     //   "${_counter.value}",
                                  //     //   style: const TextStyle(
                                  //     //     fontSize: 60,
                                  //     //     fontWeight: FontWeight.bold,
                                  //     //     color: Colors.white,
                                  //     //   ),
                                  //     // );
                                  //   },
                                  // ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
        .animate()
        .slideY(
          curve: Curves.fastOutSlowIn,
          duration: SizeConstants.duration,
          begin: 1.3,
          delay: SizeConstants.delay2,
        )
        .fade(duration: SizeConstants.duration, delay: SizeConstants.delay2)
        .blur(begin: Offset(4, 4), delay: SizeConstants.delay2);
  }

  double _calculateTextWidth(String text, ThemeData theme) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: theme.textTheme.titleMedium),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.size.width + 20; // Add some extra padding
  }
}
