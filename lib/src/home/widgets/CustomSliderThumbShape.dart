
import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/colours.dart';

class CustomThumbShape extends SliderComponentShape {
  final IconData icon;
  final double thumbRadius;

  const CustomThumbShape({required this.icon, required this.thumbRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Draw blur background
    final blurPaint = Paint()
      ..color = Colours.whiteColor.withValues(alpha: 0.8)
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 0.0);
    canvas.drawCircle(center, thumbRadius, blurPaint);

    // Draw main thumb background
    final thumbPaint = Paint()
      ..color = Colours.whiteColor.withValues(alpha: 0.30)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius - 2, thumbPaint);

    // Draw border
    final borderPaint = Paint()
      ..color = Colours.primaryColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(center, thumbRadius - 2, borderPaint);

    // Draw shadow
    // final shadowPaint = Paint()
    //   ..color = Colours.whiteColor.withValues(alpha: 0.2)
    //   ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6.0);
    // canvas.drawCircle(center + Offset(0, 2), thumbRadius - 3, shadowPaint);

    // Draw icon
    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: Colours.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: textDirection,
    );

    iconPainter.layout();
    iconPainter.paint(
      canvas,
      center - Offset(iconPainter.width / 2, iconPainter.height / 2),
    );

    // Add subtle glow effect
    final glowPaint = Paint()
      ..color = Colours.primaryColor.withOpacity(0.05)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8.0);

    canvas.drawCircle(center, thumbRadius + 5, glowPaint);
  }
}

class CustomRangeThumbShape extends RangeSliderThumbShape {
  final IconData icon;
  final double thumbRadius;

  const CustomRangeThumbShape({required this.icon, required this.thumbRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete=false,
    bool isEnabled=true,
    bool isOnTop=true,
    TextDirection textDirection=TextDirection.ltr,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool isPressed=true,
  }) {
    final Canvas canvas = context.canvas;

    // Draw blur background
    final blurPaint = Paint()
      ..color = Colours.whiteColor.withValues(alpha: 0.8)
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 0.0);
    canvas.drawCircle(center, thumbRadius, blurPaint);

    // Draw main thumb background
    final thumbPaint = Paint()
      ..color = Colours.whiteColor.withValues(alpha: 0.30)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius - 2, thumbPaint);

    // Draw border
    final borderPaint = Paint()
      ..color = Colours.primaryColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(center, thumbRadius - 2, borderPaint);

    // Draw shadow
    // final shadowPaint = Paint()
    //   ..color = Colours.whiteColor.withValues(alpha: 0.2)
    //   ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6.0);
    // canvas.drawCircle(center + Offset(0, 2), thumbRadius - 3, shadowPaint);

    // Draw icon
    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: Colours.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: textDirection,
    );

    iconPainter.layout();
    iconPainter.paint(
      canvas,
      center - Offset(iconPainter.width / 2, iconPainter.height / 2),
    );

    // Add subtle glow effect
    final glowPaint = Paint()
      ..color = Colours.primaryColor.withOpacity(0.05)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8.0);

    canvas.drawCircle(center, thumbRadius + 5, glowPaint);
  }

  // @override
  // void paint(
  //   PaintingContext context,
  //   Offset center, {
  //   required Animation<double> activationAnimation,
  //   required Animation<double> enableAnimation,
  //   required bool isDiscrete,
  //   required TextPainter labelPainter,
  //   required RenderBox parentBox,
  //   required SliderThemeData sliderTheme,
  //   required TextDirection textDirection,
  //   required double value,
  //   required double textScaleFactor,
  //   required Size sizeWithOverflow,
  // }) {
  //   final Canvas canvas = context.canvas;
  //
  //   // Draw blur background
  //   final blurPaint = Paint()
  //     ..color = Colours.whiteColor.withValues(alpha: 0.8)
  //     ..maskFilter = MaskFilter.blur(BlurStyle.inner, 0.0);
  //   canvas.drawCircle(center, thumbRadius, blurPaint);
  //
  //   // Draw main thumb background
  //   final thumbPaint = Paint()
  //     ..color = Colours.whiteColor.withValues(alpha: 0.30)
  //     ..style = PaintingStyle.fill;
  //
  //   canvas.drawCircle(center, thumbRadius - 2, thumbPaint);
  //
  //   // Draw border
  //   final borderPaint = Paint()
  //     ..color = Colours.primaryColor.withValues(alpha: 0.3)
  //     ..style = PaintingStyle.stroke
  //     ..strokeWidth = 1.5;
  //
  //   canvas.drawCircle(center, thumbRadius - 2, borderPaint);
  //
  //   // Draw shadow
  //   // final shadowPaint = Paint()
  //   //   ..color = Colours.whiteColor.withValues(alpha: 0.2)
  //   //   ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6.0);
  //   // canvas.drawCircle(center + Offset(0, 2), thumbRadius - 3, shadowPaint);
  //
  //   // Draw icon
  //   final iconPainter = TextPainter(
  //     text: TextSpan(
  //       text: String.fromCharCode(icon.codePoint),
  //       style: TextStyle(
  //         fontSize: 18.0,
  //         fontFamily: icon.fontFamily,
  //         package: icon.fontPackage,
  //         color: Colours.primaryColor,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //     textDirection: textDirection,
  //   );
  //
  //   iconPainter.layout();
  //   iconPainter.paint(
  //     canvas,
  //     center - Offset(iconPainter.width / 2, iconPainter.height / 2),
  //   );
  //
  //   // Add subtle glow effect
  //   final glowPaint = Paint()
  //     ..color = Colours.primaryColor.withOpacity(0.05)
  //     ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8.0);
  //
  //   canvas.drawCircle(center, thumbRadius + 5, glowPaint);
  // }
}
