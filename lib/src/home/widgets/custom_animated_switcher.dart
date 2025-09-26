import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/size_const.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  final Offset begin, end;
  final Duration duration;
  final Curve curve;
  final bool withSize;

  const CustomAnimatedSwitcher({
    super.key,
    required this.child,
    this.duration = SizeConstants.duration,
    this.curve = Curves.easeInOut,
    this.withSize = false,
    this.begin = const Offset(0.0, 0.3),
    this.end = const Offset(0.0, 0.0),
  });

  const CustomAnimatedSwitcher.withSize({
    super.key,
    required this.child,
    this.duration = SizeConstants.duration,
    this.curve = Curves.easeInOut,
    this.withSize = true,
    this.begin = const Offset(0.0, 0.3),
    this.end = const Offset(0.0, 0.0),
  });

  @override
  Widget build(BuildContext context) {
    if (withSize) {
      return AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: begin,
                end: end,
              ).animate(animation),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.7, end: 1.0).animate(animation),
                child: child,
              ),
            ),
          );
        },
        duration: duration,
        switchInCurve: curve,
        switchOutCurve: curve,
        child: child,
      );
    } else {
      return AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: begin,
                end: end,
              ).animate(animation),
              child: child,
            ),
          );
        },
        duration: duration,
        switchInCurve: curve,
        switchOutCurve: curve,
        child: child,
      );
    }
  }
}

