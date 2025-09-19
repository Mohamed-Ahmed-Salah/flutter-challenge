import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/enums.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/controllers/page_controller.dart';
import 'package:flutter_challenge/src/home/pages/page2.dart';
import 'package:flutter_challenge/src/home/pages/page3.dart';
import 'package:flutter_challenge/src/home/pages/page4.dart';
import 'package:flutter_challenge/src/home/pages/page5.dart';
import 'package:flutter_challenge/src/home/pages/page6.dart';
import 'package:flutter_challenge/src/home/widgets/backgroudn.dart';
import 'package:flutter_challenge/src/home/widgets/custom_animated_sqitcher.dart';
import 'package:flutter_challenge/src/home/widgets/dots_indicator.dart';
import 'package:flutter_challenge/src/home/widgets/next_back_button.dart';
import 'package:flutter_challenge/src/home/pages/page1.dart';
import 'package:flutter_challenge/src/home/widgets/title_text.dart';
import 'package:flutter_challenge/src/home/widgets/top_dot_indicator_row.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageState pageSata = PageState.letsGetStarted;

  @override
  Widget build(BuildContext context) {
    ///performance
    final theme = Theme.of(context);

    return Scaffold(
      body: PageBackground(
        child: SafeArea(
          child: Consumer<PageSataProvider>(
            builder: (context, controller, _) {
              return Stack(
                children: <Widget>[
                  ///Top Section page dots indicator
                  TopDotIndicatorRow(controller: controller),

                  ///title for each page
                  TitleTexts(controller: controller),

                  ///First Page Welcome Page
                  CustomAnimatedSwitcher.withSize(
                    duration: SizeConstants.duration,
                    curve: SizeConstants.mainCurve,
                    child: controller.currentPage == PageState.letsGetStarted
                        ? Page1()
                        : SizedBox(),
                  ),

                  /// page 3
                  Positioned(
                    top: 120,
                    child: CustomAnimatedSwitcher.withSize(
                      duration: SizeConstants.duration,
                      curve: SizeConstants.mainCurve,
                      child: controller.currentIndex == 2
                          ? Page3()
                          : SizedBox(),
                    ),
                  ),

                  Positioned(
                    top: 120,
                    child: CustomAnimatedSwitcher(
                      duration: SizeConstants.duration,
                      curve: SizeConstants.mainCurve,
                      child: controller.currentPage != PageState.letsGetStarted
                          ? _getPage(controller.currentIndex - 1)
                          : SizedBox(),
                    ),
                  ),

                  ///button next and back
                  BackNextButton(controller: controller),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Page2();
      case 1:
        return SizedBox.shrink();
      case 2:
        return Page4();
      case 3:
        return Page5();
      case 4:
        return Page6();
      case 5:
        return Page7();
      default:
        return SizedBox.shrink();
    }
  }
}

class Page7 extends StatelessWidget {
  const Page7({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("page 7");
  }
}
