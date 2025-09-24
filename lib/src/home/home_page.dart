import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/enums.dart';
import 'package:flutter_challenge/config/media.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/controllers/page_controller.dart';
import 'package:flutter_challenge/src/home/insurance_plan_model.dart';
import 'package:flutter_challenge/src/home/pages/page2.dart';
import 'package:flutter_challenge/src/home/pages/page3.dart';
import 'package:flutter_challenge/src/home/pages/page4.dart';
import 'package:flutter_challenge/src/home/pages/page5.dart';
import 'package:flutter_challenge/src/home/pages/page6.dart';
import 'package:flutter_challenge/src/home/widgets/backgroudn.dart';
import 'package:flutter_challenge/src/home/widgets/custom_animated_sqitcher.dart';
import 'package:flutter_challenge/src/home/widgets/dots_indicator.dart';
import 'package:flutter_challenge/src/home/widgets/next_back_button.dart';
import 'package:flutter_challenge/src/home/pages/page1.dart';
import 'package:flutter_challenge/src/home/widgets/page_sizer.dart';
import 'package:flutter_challenge/src/home/widgets/title_text.dart';
import 'package:flutter_challenge/src/home/widgets/top_dot_indicator_row.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late PageSataProvider _pageStateProvider; // Store reference

  late AnimationController _counterController;
  late Animation<int> _counter;
  PageState pageSata = PageState.letsGetStarted;

  @override
  void initState() {
    super.initState();

    _pageStateProvider = Provider.of<PageSataProvider>(context, listen: false);

    _counterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _counterController.addListener(_counterListener);
    _counter = IntTween(begin: 0, end: 100).animate(_counterController);
  }

  _counterListener() {
    if (_counterController.isCompleted) {
      _pageStateProvider.navToFinishPage();
    }
  }

  @override
  void dispose() {
    _counterController.removeListener(_counterListener);
    _counterController.dispose();
    super.dispose();
  }

  void _startCounter(int index) async {
    await Future.delayed(Duration(seconds: 1)).then((_) {
      if (index == 5 && !_counterController.isAnimating) {
        _counterController.forward(from: 0); // start animation from 0
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ///performance
    final theme = Theme.of(context);

    return Scaffold(
      body: PageBackground(
        child: SafeArea(
          child: Consumer<PageSataProvider>(
            builder: (context, controller, _) {
              _startCounter(controller.currentIndex);
              return Stack(
                children: <Widget>[
                  ///Top Section page dots indicator
                  TopDotIndicatorRow(controller: controller),

                  ///title for each page
                  TitleTexts(controller: controller),

                  ///First Page Welcome Page
                  CustomAnimatedSwitcher.withSize(
                    duration: SizeConstants.duration,
                    curve: SizeConstants.mainCurve,
                    child: controller.currentPage == PageState.letsGetStarted
                        ? Page1()
                        : SizedBox(),
                  ),

                  /// page 3
                  Positioned(
                    top: 120,
                    child: CustomAnimatedSwitcher.withSize(
                      duration: SizeConstants.duration,
                      curve: SizeConstants.mainCurve,
                      child: controller.currentIndex == 2
                          ? Page3()
                          : SizedBox(),
                    ),
                  ),

                  Positioned(
                    top: 120,
                    child: CustomAnimatedSwitcher(
                      duration: SizeConstants.duration,
                      curve: SizeConstants.mainCurve,
                      child: controller.currentPage != PageState.letsGetStarted
                          ? _getPage(controller.currentIndex - 1)
                          : SizedBox(),
                    ),
                  ),

                  ///button next and back
                  BackNextButton(controller: controller, counter: _counter),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Page2();
      case 1:
        return SizedBox.shrink();
      case 2:
        return Page4();
      case 3:
        return Page5();
      case 4:
        return Page6();
      case 5:
        return Page7();
      case 6:
        return Page7();
      case 7:
        return Page8();
      default:
        return SizedBox.shrink();
    }
  }
}

class Page7 extends StatelessWidget {
  const Page7({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageSize(
      child: Container(
        width: double.infinity,
        // color: Colors.blue,
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
                // color: Colors.red,
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

class Page8 extends StatefulWidget {
  const Page8({super.key});

  @override
  State<Page8> createState() => _Page8State();
}

class _Page8State extends State<Page8> {
  final CardSwiperController controller = CardSwiperController();
  List<InsurancePlan> plans = List.from(mockPlans);

  @override
  Widget build(BuildContext context) {
    return PageSize(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            child: plans.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.health_and_safety_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No more plans to review',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'All insurance plans have been reviewed',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[500]),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              plans = List.from(mockPlans);
                            });
                          },
                          child: const Text('Reset Plans'),
                        ),
                      ],
                    ),
                  )
                : CardSwiper(
                    controller: controller,
                    cardsCount: plans.length,
                    onSwipe: _onSwipe,
                    onUndo: _onUndo,
                    numberOfCardsDisplayed: 2,
                    backCardOffset: const Offset(0, 20),
                    padding: const EdgeInsets.all(24.0),
                    cardBuilder:
                        (
                          context,
                          index,
                          horizontalThreshold,
                          verticalThreshold,
                        ) => InsurancePlanCard(plan: plans[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    // final swipedPlan = plans[previousIndex];
    //
    // // Show a snackbar with the action
    // String action = direction == CardSwiperDirection.right ? 'Liked' : 'Passed';
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('$action ${swipedPlan.title}'),
    //     duration: const Duration(seconds: 1),
    //   ),
    // );
    //
    // // Remove the swiped plan after a delay
    // Future.delayed(const Duration(milliseconds: 300), () {
    //   setState(() {
    //     plans.removeAt(previousIndex);
    //   });
    // });

    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    // Add back the last swiped plan if there was one
    // if (previousIndex != null && mockPlans.length > plans.length) {
    //   setState(() {
    //     plans.insert(0, mockPlans[mockPlans.length - plans.length - 1]);
    //   });
    // }
    return true;
  }
}

class InsurancePlanCard extends StatelessWidget {
  final InsurancePlan plan;

  const InsurancePlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeConstants.outerBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Expanded(
            child: Container(
              // color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeConstants.innerContainerPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubtitle(context),
                    const SizedBox(height: SizeConstants.verticalSpace),

                    Row(
                      children: [
                        Row(
                          children: [
                            CustomPercentIndicator(
                              percent: 0.60,
                              strokeWidth: 10,
                              radius: 35,
                              startAngle: -90 * math.pi / 180,
                              // Start from top
                              fillGradient: LinearGradient(
                                begin: AlignmentGeometry.topCenter,
                                end: AlignmentGeometry.bottomCenter,
                                colors: [Colors.grey.shade100, Colors.blue],
                              ),
                              backgroundGradient: SweepGradient(
                                colors: [
                                  Colors.grey.shade100,
                                  Colors.grey.shade100,
                                ],
                              ),
                              center: Icon(Icons.star, color: Colors.blue),
                            ),
                            SizedBox(width: SizeConstants.smallInnerPadding),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Match",
                                  style: TextStyle(
                                    // fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  plan.matchPercentage.toString(),
                                  style: TextStyle(
                                    // fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(
                          width: SizeConstants.innerContainerPadding,
                        ),
                        Row(
                          children: [
                            CustomPercentIndicator(
                              percent: 0.60,
                              strokeWidth: 10,
                              radius: 35,
                              startAngle: -90 * math.pi / 180,
                              // Start from top
                              fillGradient: LinearGradient(
                                begin: AlignmentGeometry.topCenter,
                                end: AlignmentGeometry.bottomCenter,
                                colors: [Colors.grey.shade100, Colors.green],
                              ),
                              backgroundGradient: SweepGradient(
                                colors: [
                                  Colors.grey.shade100,
                                  Colors.grey.shade100,
                                ],
                              ),
                              center: Icon(
                                Icons.wallet_outlined,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(width: SizeConstants.smallInnerPadding),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "Price",
                                  style: TextStyle(
                                    // fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${plan.pricePerMonth}/m",
                                  style: TextStyle(
                                    // fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    // _buildMetrics(context),
                    const SizedBox(height: SizeConstants.verticalSpace),
                    _buildFeatures(context),
                    // const Spacer(),
                    _buildDetailsButton(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(SizeConstants.innerContainerPadding),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(plan.imageUrl, fit: BoxFit.cover),
                ),
                const SizedBox(width: SizeConstants.meduimInnerPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.type,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        plan.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.symmetric(
            horizontal: SizeConstants.innerContainerPadding,
            vertical: SizeConstants.meduimInnerPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.amber[100],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(SizeConstants.outerBorderRadius),
              bottomLeft: Radius.circular(SizeConstants.outerBorderRadius),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.amber[700], size: 16),
              const SizedBox(width: 4),
              Text(
                plan.rating.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.amber[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      plan.subtitle,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700], height: 1.4),
    );
  }

  Widget _buildMetrics(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricItem(
            context,
            'Your Match',
            '${plan.matchPercentage}%',
            Colors.blue,
            Icons.favorite,
          ),
        ),
        const SizedBox(width: SizeConstants.innerContainerPadding),
        Expanded(
          child: _buildMetricItem(
            context,
            'Price',
            '\$${plan.pricePerMonth.toInt()}/m',
            Colors.green,
            Icons.attach_money,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricItem(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(SizeConstants.meduimInnerPadding),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(SizeConstants.innerBorderRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures(BuildContext context) {
    // final enabledFeatures = plan.categories.entries
    //     .where((entry) => entry.value)
    //     .map((entry) => entry.key)
    //     .toList();
    //
    // final disabledFeatures = plan.categories.entries
    //     .where((entry) => !entry.value)
    //     .map((entry) => entry.key)
    //     .toList();

    return Expanded(
      child: Container(
        // color: Colors.red,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 0.0, // Spacing between columns
            mainAxisSpacing: 0.0, // Spacing between rows
            childAspectRatio: 4, // Aspect ratio of each child
          ),
          itemCount: plan.categories.length,
          itemBuilder: (BuildContext context, int index) {
            final String categoryKey = plan.categories.keys.elementAt(index);
            final bool enabled = plan.categories[categoryKey] ?? false;
            return Row(
              children: [
                Icon(
                  enabled ? Icons.check : Icons.close,
                  color: enabled
                      ? Theme.of(context).primaryColor
                      : Colors.grey[400],
                  size: 16,
                ),
                Text(
                  categoryKey,
                  style: TextStyle(color: enabled ? null : Colors.grey[400]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String feature, bool enabled) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SizeConstants.smallInnerPadding),
      child: Row(
        children: [
          Icon(
            enabled ? Icons.check_circle : Icons.cancel,
            color: enabled ? Colors.green[600] : Colors.grey[400],
            size: 20,
          ),
          const SizedBox(width: SizeConstants.smallInnerPadding),
          Text(
            feature,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: enabled ? Colors.grey[800] : Colors.grey[500],
              decoration: enabled ? null : TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConstants.verticalSpace),
      padding: EdgeInsets.all(SizeConstants.meduimInnerPadding),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,

        borderRadius: BorderRadius.circular(SizeConstants.outerBorderRadius),
      ),
      width: double.infinity,
      child: Center(
        child: Text(
          'Details',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

class CustomCircularProgress extends StatefulWidget {
  final double percentage;
  final double radius;
  final double strokeWidth;
  final List<Color> progressGradient;
  final Color backgroundColor;
  final Widget? center;
  final Duration animationDuration;

  const CustomCircularProgress({
    Key? key,
    required this.percentage,
    this.radius = 60,
    this.strokeWidth = 8,
    this.progressGradient = const [Colors.blue, Colors.lightBlueAccent],
    this.backgroundColor = const Color(0xFFE8E8E8),
    this.center,
    this.animationDuration = const Duration(milliseconds: 1500),
  }) : super(key: key);

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
    Key? key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.icon,
    this.primaryGradient = const [Colors.blue, Colors.lightBlueAccent],
    this.backgroundColor = const Color(0xFFE8E8E8),
    this.radius = 60,
  }) : super(key: key);

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
                    primaryGradient.first.withOpacity(0.15),
                    primaryGradient.last.withOpacity(0.05),
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
