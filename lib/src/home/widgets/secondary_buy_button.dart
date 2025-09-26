
import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/size_const.dart';
class SecondaryBuyButtons extends StatelessWidget {
  final IconData icon;
  final bool showButton;

  const SecondaryBuyButtons({
    super.key,
    required this.icon,
    required this.showButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        );
      },
      duration: SizeConstants.duration,
      switchInCurve: SizeConstants.mainCurve,
      switchOutCurve: SizeConstants.mainCurve,
      child: showButton
          ? Container(
        decoration: BoxDecoration(
          color: Colours.whiteColor.withValues(alpha: 0.4),

          borderRadius: BorderRadius.all(
            Radius.circular(SizeConstants.fullBorderRadius),
          ),
        ),
        padding: EdgeInsets.all(SizeConstants.innerContainerPadding),
        child: Icon(icon, color: theme.primaryColor),
      )
          : SizedBox.shrink(),
    );
  }
}
