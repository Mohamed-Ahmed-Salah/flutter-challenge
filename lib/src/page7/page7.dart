
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/media.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/widgets/page_sizer.dart';

class Page7 extends StatelessWidget {
  const Page7({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageSize(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Thanks!",
              style: theme.textTheme.displayMedium?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ).animate().scale(
              curve: Curves.bounceOut,
              duration: SizeConstants.duration,
              delay: Duration(
                milliseconds: SizeConstants.mainMilliSecondsDuration,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Image.asset(Media.lama, fit: BoxFit.cover)
                    .animate()
                    .scale(
                  curve: SizeConstants.mainCurve,
                  duration: SizeConstants.duration,
                  alignment: Alignment.bottomCenter,
                  delay: Duration(
                    milliseconds: SizeConstants.mainMilliSecondsDuration,
                  ),
                ),
              ),
            ),
            Text(
              "Now let's find the plans that will fit you -"
                  "\n your health, your needs, your peace.",
              style: TextStyle(fontSize: 19),
            )
                .animate()
                .fadeIn(
              curve: SizeConstants.mainCurve,
              duration: SizeConstants.duration,
              delay: Duration(
                milliseconds: SizeConstants.mainMillisecondsSlideDuration,
              ),
            )
                .slideY(begin: 0.5, curve: SizeConstants.mainCurve),
            Spacer(),
          ],
        ),
      ),
    );
  }
}