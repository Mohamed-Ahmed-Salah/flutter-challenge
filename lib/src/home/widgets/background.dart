import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/colours.dart';
class PageBackground extends StatelessWidget {
  final Widget child;

  const PageBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.bottomRight,
          stops: [0.7, 1],
          colors: [Colours.redBackground, Colours.greenBackground],
        ),
      ),
      height: double.infinity,
      width: double.infinity,
      child: child,
    );
  }
}
