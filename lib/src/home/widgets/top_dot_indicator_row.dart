import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/enums.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/controllers/page_controller.dart';
import 'package:flutter_challenge/src/home/widgets/backgroudn.dart';
import 'package:flutter_challenge/src/home/widgets/custom_animated_sqitcher.dart';
import 'package:flutter_challenge/src/home/widgets/dots_indicator.dart';
import 'package:flutter_challenge/src/home/widgets/next_back_button.dart';
import 'package:flutter_challenge/src/home/pages/page1.dart';
import 'package:flutter_challenge/src/home/widgets/title_text.dart';
import 'package:provider/provider.dart';
class TopDotIndicatorRow extends StatelessWidget {
  final PageSataProvider controller;

  const TopDotIndicatorRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: CustomAnimatedSwitcher(
        begin: const Offset(0.0, -0.3),
        end: const Offset(0.0, 0.0),
        duration: SizeConstants.duration,
        curve: Curves.easeOutCubic,
        child: controller.currentPage == PageState.letsGetStarted
            ? SizedBox()
            : Padding(
          padding: const EdgeInsets.all(
            SizeConstants.innerContainerPadding,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<PageSataProvider>().back(),
                  icon: Icon(Icons.close),
                ),
                Expanded(child: DotsIndicator()),
                Icon(Icons.more_horiz),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
