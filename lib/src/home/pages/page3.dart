import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/enums.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/controllers/page_controller.dart';
import 'package:flutter_challenge/src/home/pages/page2.dart';
import 'package:flutter_challenge/src/home/pages/page3.dart';
import 'package:flutter_challenge/src/home/widgets/backgroudn.dart';
import 'package:flutter_challenge/src/home/widgets/custom_animated_sqitcher.dart';
import 'package:flutter_challenge/src/home/widgets/dots_indicator.dart';
import 'package:flutter_challenge/src/home/widgets/next_back_button.dart';
import 'package:flutter_challenge/src/home/widgets/page1.dart';
import 'package:flutter_challenge/src/home/widgets/title_text.dart';
import 'package:flutter_challenge/src/home/widgets/top_dot_indicator_row.dart';
import 'package:provider/provider.dart';
class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final FixedExtentScrollController _controller = FixedExtentScrollController(
    initialItem: 1,
  );

  final FixedExtentScrollController _scrollController =
  FixedExtentScrollController(initialItem: 5);
  int _selectedIndex = 5; // Start with index 1 (32) selected

  bool _isScrolling = false;
  bool hasChangedInitialValue = false;

  final List<int> numbers = List.generate(30, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final mediaQuery = MediaQuery.of(context);
    return Container(
      alignment: Alignment.topCenter,
      height: mediaQuery.size.height * 0.8,
      width: mediaQuery.size.width,
      // color: Colors.red.withValues(alpha: 0.1),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            setState(() => _isScrolling = true);
            hasChangedInitialValue = true;
          } else if (notification is ScrollEndNotification) {
            setState(() => _isScrolling = false);
          }
          return true;
        },
        child: Column(
          children: [
            Expanded(
              child: ListWheelScrollView.useDelegate(
                controller: _scrollController,
                itemExtent: 60,
                perspective: 0.003,
                diameterRatio: 2,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: numbers.length,
                  builder: (context, index) {
                    final isSelected = index == _selectedIndex;
                    return AnimatedOpacity(
                      opacity:
                      !_isScrolling && !isSelected && hasChangedInitialValue
                          ? 0
                          : 1,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        width: mediaQuery.size.width * 0.8,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(
                            SizeConstants.innerBorderRadius,
                          ),
                        ),
                        // margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.withValues(alpha: 0.2),
                              letterSpacing: 1.2,
                            ),
                            child: Text('${numbers[index]}'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(flex: 2, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}