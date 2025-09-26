import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomCircularProgress extends StatefulWidget {
  final double percentage;
  final double radius;
  final double strokeWidth;
  final List<Color> progressGradient;
  final Color backgroundColor;
  final Widget? center;
  final Duration animationDuration;

  const CustomCircularProgress({
    super.key,
    required this.percentage,
    this.radius = 60,
    this.strokeWidth = 8,
    this.progressGradient = const [Colors.blue, Colors.lightBlueAccent],
    this.backgroundColor = const Color(0xFFE8E8E8),
    this.center,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  _CustomCircularProgressState createState() => _CustomCircularProgressState();
}

class _CustomCircularProgressState extends State<CustomCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.percentage / 100).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: GradientCircularProgressPainter(
              percentage: _animation.value,
              strokeWidth: widget.strokeWidth,
              progressGradient: widget.progressGradient,
              backgroundColor: widget.backgroundColor,
            ),
            child: widget.center != null
                ? Center(child: widget.center)
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final List<Color> progressGradient;
  final Color backgroundColor;

  GradientCircularProgressPainter({
    required this.percentage,
    required this.strokeWidth,
    required this.progressGradient,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    if (percentage > 0) {
      // Create gradient for progress
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: -math.pi / 2 + (2 * math.pi * percentage),
        colors: progressGradient,
        stops: [0.0, 1.0],
      );

      final progressPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      // Draw progress arc
      final sweepAngle = 2 * math.pi * percentage;
      canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, progressPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MetricsWidget extends StatelessWidget {
  final String title;
  final String value;
  final double percentage;
  final IconData icon;
  final List<Color> primaryGradient;
  final Color backgroundColor;
  final double radius;

  const MetricsWidget({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.icon,
    this.primaryGradient = const [Colors.blue, Colors.lightBlueAccent],
    this.backgroundColor = const Color(0xFFE8E8E8),
    this.radius = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Custom Circular Progress with Gradient
          CustomCircularProgress(
            percentage: percentage,
            radius: radius,
            strokeWidth: 10,
            progressGradient: primaryGradient,
            backgroundColor: backgroundColor,
            center: Container(
              width: radius * 1.2,
              height: radius * 1.2,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    primaryGradient.first.withValues(alpha: 0.15),
                    primaryGradient.last.withValues(alpha: 0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: radius * 0.4,
                color: primaryGradient.first,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Value
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPercentIndicator extends StatelessWidget {
  final double percent; // 0.0 -> 1.0
  final double strokeWidth;
  final double radius;
  final double startAngle; // in radians
  final Gradient fillGradient;
  final Gradient backgroundGradient;
  final Widget? center;

  const CustomPercentIndicator({
    super.key,
    required this.percent,
    this.strokeWidth = 12,
    this.radius = 80,
    this.startAngle = -90 * 3.1415926535 / 180, // default top center
    required this.fillGradient,
    required this.backgroundGradient,
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(radius * 2, radius * 2),
            painter: _CirclePainter(
              percent: percent,
              strokeWidth: strokeWidth,
              startAngle: startAngle,
              fillGradient: fillGradient,
              backgroundGradient: backgroundGradient,
            ),
          ),
          if (center != null) center!,
        ],
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double percent;
  final double strokeWidth;
  final double startAngle;
  final Gradient fillGradient;
  final Gradient backgroundGradient;

  _CirclePainter({
    required this.percent,
    required this.strokeWidth,
    required this.startAngle,
    required this.fillGradient,
    required this.backgroundGradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paintBackground = Paint()
      ..shader = backgroundGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final paintFill = Paint()
      ..shader = fillGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final radius = size.width / 2;
    final center = Offset(radius, radius);

    // Draw background circle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      2 * 3.1415926535,
      false,
      paintBackground,
    );

    // Draw filled arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      percent * 2 * 3.1415926535,
      false,
      paintFill,
    );
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) {
    return oldDelegate.percent != percent ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.fillGradient != fillGradient ||
        oldDelegate.backgroundGradient != backgroundGradient;
  }
}