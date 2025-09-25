import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/size_const.dart';
import "package:flutter_animate/flutter_animate.dart";

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlutterLogo(size: 70).animate().slideY(
            duration: SizeConstants.duration,
            curve: Curves.fastOutSlowIn,
            delay: SizeConstants.delay,
            begin: 1,
          ),

          ...[
                SizedBox(height: SizeConstants.verticalSpace),
                Text("Welcome to", style: theme.textTheme.titleLarge),
                // SizedBox(height: SizeConstants.verticalSpace,),
                Text(
                  "MediCover",
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor,
                  ),
                ),
              ]
              .animate()
              .slideY(
                curve: Curves.fastOutSlowIn,
                duration: SizeConstants.duration,
                begin: 1.3,
                delay: SizeConstants.delay2,
              )
              .fade(
                duration: SizeConstants.duration,
                delay: SizeConstants.delay2,
              )
              .blur(begin: Offset(4, 4), delay: SizeConstants.delay2),
        ],
      ),
    );
  }
}
