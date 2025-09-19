
import 'package:flutter/material.dart';

class PageSize extends StatelessWidget {
  final Widget child;
  const PageSize({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Container(
      alignment: Alignment.topCenter,
      height: mediaQuery.size.height * 0.8,
      width: mediaQuery.size.width,
      child: child,
    );
  }
}

