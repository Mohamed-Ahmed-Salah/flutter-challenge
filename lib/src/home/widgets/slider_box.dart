
import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/size_const.dart';

class SliderBox extends StatelessWidget {
  final Widget child;
  const SliderBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery
        .of(context)
        .size;
    return Container(
      height: mediaQuery.height * 0.2,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConstants.innerContainerPadding,
        vertical: SizeConstants.innerContainerPadding,
      ),
      decoration: BoxDecoration(
        color: Colours.whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(SizeConstants.outerBorderRadius),
        ),
      ),
      child: child,
    );
  }
}
