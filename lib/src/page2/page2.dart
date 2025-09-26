import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/widgets/selectable_cards.dart';

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

