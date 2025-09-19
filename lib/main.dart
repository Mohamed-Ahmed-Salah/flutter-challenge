import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/src/home/controllers/page_controller.dart';
import 'package:flutter_challenge/src/home/home_page.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PageSataProvider())],
      child: MaterialApp(
        title: 'Flutter Challenge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          chipTheme: ChipThemeData(
            padding: EdgeInsets.symmetric(horizontal:  SizeConstants.smallInnerPadding,
            vertical: SizeConstants.meduimInnerPadding
            ),
            showCheckmark: false,
            selectedColor: Colours.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                SizeConstants.fullBorderRadius,
              ),
            ),
            shadowColor: Colours.primaryColor,
          ),
          brightness: Brightness.light,
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colours.primaryColor,
            linearTrackColor: Colours.primaryColor.withValues(alpha: 0.4),
            circularTrackColor: Colours.primaryColor.withValues(alpha: 0.3),
          ),

          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colours.primaryColor,
          ),
          primaryColor: Colours.primaryColor,

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colours.primaryColor,
              disabledBackgroundColor: Colours.primaryColor,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(SizeConstants.fullBorderRadius),
                ),
              ),
            ),
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
