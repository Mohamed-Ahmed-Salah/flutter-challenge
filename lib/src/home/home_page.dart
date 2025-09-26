
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/enums.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/controllers/page_controller.dart';
import 'package:flutter_challenge/src/page2/page2.dart';
import 'package:flutter_challenge/src/page3/page3.dart';
import 'package:flutter_challenge/src/page4/page4.dart';
import 'package:flutter_challenge/src/page5/page5.dart';
import 'package:flutter_challenge/src/page6/page6.dart';
import 'package:flutter_challenge/src/home/widgets/background.dart';
import 'package:flutter_challenge/src/home/widgets/custom_animated_switcher.dart';
import 'package:flutter_challenge/src/home/widgets/next_back_button.dart';
import 'package:flutter_challenge/src/page1/page1.dart';
import 'package:flutter_challenge/src/home/widgets/title_text.dart';
import 'package:flutter_challenge/src/home/widgets/top_dot_indicator_row.dart';
import 'package:flutter_challenge/src/page7/page7.dart';
import 'package:flutter_challenge/src/page8/page8.dart';
import 'package:provider/provider.dart';

import 'widgets/secondary_buy_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late PageSataProvider _pageStateProvider; // Store reference

  late AnimationController _counterController;
  late Animation<int> _counter;
  PageState pageSata = PageState.letsGetStarted;

  @override
  void initState() {
    super.initState();

    _pageStateProvider = Provider.of<PageSataProvider>(context, listen: false);

    _counterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _counterController.addListener(_counterListener);
    _counter = IntTween(begin: 0, end: 100).animate(_counterController);
  }

  _counterListener() {
    if (_counterController.isCompleted) {
      _pageStateProvider.navToFinishPage();
    }
  }

  @override
  void dispose() {
    _counterController.removeListener(_counterListener);
    _counterController.dispose();
    super.dispose();
  }

  void _startCounter(int index) async {
    await Future.delayed(Duration(seconds: 1)).then((_) {
      if (index == 6 && !_counterController.isAnimating) {
        _counterController.forward(from: 0); // start animation from 0
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ///performance
    final theme = Theme.of(context);

    return Scaffold(
      body: PageBackground(
        child: SafeArea(
          child: Consumer<PageSataProvider>(
            builder: (context, controller, _) {
              _startCounter(controller.currentIndex);
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
                  BackNextButton(controller: controller, counter: _counter),

                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: SecondaryBuyButtons(
                      showButton: controller.currentPage == PageState.buyPlan,
                      icon: CupertinoIcons.heart_fill,
                    ),
                  ),

                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: SecondaryBuyButtons(
                      showButton: controller.currentPage == PageState.buyPlan,
                      icon: CupertinoIcons.chart_bar_square_fill,
                    ),
                  ),
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
      case 6:
        return Page7();
      case 7:
        return Page8();
      default:
        return SizedBox.shrink();
    }
  }
}

