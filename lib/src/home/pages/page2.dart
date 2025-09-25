import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/size_const.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int selectedIndex = 0;
  List<String> options = [
    "😊 Just me",
    "👪 Family",
    "👶 Children",
    "😎 Someone else",
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
          alignment: Alignment.topCenter,
          height: mediaQuery.size.height * 0.8,
          width: mediaQuery.size.width,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (_, index) {
              return SelectableCard(
                text: options[index],
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              );
            },
          ),
        )
        .animate()
        .slideY(
          begin: 0.2,
          duration: SizeConstants.duration,
          delay: SizeConstants.pageTransitionDelay,
          curve: SizeConstants.mainCurve,
        )
        .fade();
  }
}

class SelectableCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableCard({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Center(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) {
          // This ensures taps on overlapping cards are captured
        },
        child: AnimatedContainer(
          width: mediaQuery.size.width * 0.8,

          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: SizeConstants.horizontalPadding,
          ),
          padding: EdgeInsets.symmetric(
            vertical: SizeConstants.innerContainerPadding,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(
              SizeConstants.innerBorderRadius,
            ),
          ),
          duration: SizeConstants.durationSmall,
          curve: SizeConstants.mainCurve,
          child: Center(
            child: AnimatedDefaultTextStyle(
              // text,
              duration: SizeConstants.durationSmall,
              // curve: Curves.easeInOut,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? theme.primaryColor : Colors.grey,
                fontWeight: FontWeight.normal,
              ),
              child: Text(text),
            ),
          ),
        ),
      ),
    );
  }
}
