import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/enums.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/controllers/page_controller.dart';
import 'package:flutter_challenge/src/home/widgets/backgroudn.dart';
import 'package:flutter_challenge/src/home/widgets/custom_animated_sqitcher.dart';
import 'package:flutter_challenge/src/home/widgets/dots_indicator.dart';
import 'package:flutter_challenge/src/home/pages/page1.dart';
import 'package:provider/provider.dart';

class TitleTexts extends StatelessWidget {
  final PageSataProvider controller;

  const TitleTexts({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      left: 0,
      right: 0,
      child: CustomAnimatedSwitcher(
        duration: SizeConstants.duration,
        curve: Curves.easeInOut,

        child: controller.currentPage == PageState.letsGetStarted
            ? SizedBox()
            : SequentialTextSwitcher(
                duration: Duration(milliseconds: 350),
                // text:
                //     titles[controller.currentIndex %
                //         titles.length],
              ),
      ),
    );
  }
}

class SequentialTextSwitcher extends StatefulWidget {
  final Duration duration;
  final bool
  showButton; // Optional: hide button if you want provider-only control

  const SequentialTextSwitcher({
    super.key,
    this.duration = const Duration(milliseconds: 500),
    this.showButton = true,
  });

  @override
  State<SequentialTextSwitcher> createState() => _SequentialTextSwitcherState();
}

class _SequentialTextSwitcherState extends State<SequentialTextSwitcher>
    with TickerProviderStateMixin {
  final List<String> texts = [
    "What do you want to ensure?",
    "What is your age?",
    "Any existing health conditions?",
    "Select what matters most to you",
    "What's you insurance budget?",
  ];
  late AnimationController _outController;
  late AnimationController _inController;

  int _lastIndex = 0;
  bool _showingOld = true;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _outController = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.duration,
    );

    _inController = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.duration,
    );
  }

  @override
  void dispose() {
    _outController.dispose();
    _inController.dispose();
    super.dispose();
  }

  void _animateToText(int newIndex) async {
    if (_isAnimating || newIndex == _lastIndex) return;

    _isAnimating = true;

    // Animate old out
    await _outController.forward();
    setState(() {
      _showingOld = false;
      _lastIndex = newIndex;
    });
    _outController.reset();

    // Animate new in
    await _inController.forward();
    _inController.reset();
    setState(() {
      _showingOld = true;
    });

    _isAnimating = false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageSataProvider>(
      builder: (context, provider, child) {
        // Get current index from provider
        final currentIndex = provider.currentIndex - 1;

        // Ensure index is within bounds
        final safeIndex = currentIndex.clamp(0, texts.length - 1);

        // Trigger animation if index changed
        if (safeIndex != _lastIndex && !_isAnimating) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _animateToText(safeIndex);
          });
        }

        final currentText = texts[_showingOld ? _lastIndex : safeIndex];
        final textTheme = Theme.of(context).textTheme;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Outgoing animation
                if (_showingOld)
                  FadeTransition(
                    opacity: Tween(begin: 1.0, end: 0.0).animate(
                      CurvedAnimation(
                        parent: _outController,
                        curve:
                            SizeConstants.mainCurve, // <-- Add your curve here
                      ),
                    ),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: const Offset(0, -0.5),
                      ).animate( CurvedAnimation(
                        parent: _outController,
                        curve: SizeConstants
                            .mainCurve, // <-- Add your curve here
                      ),),
                      child: Text(currentText, style: textTheme.titleLarge),
                    ),
                  ),

                // Incoming animation
                if (!_showingOld)
                  FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _inController,
                        curve:
                            SizeConstants.mainCurve, // <-- Add your curve here
                      ),
                    ),
                    child: SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0, -0.5),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _inController,
                              curve: SizeConstants
                                  .mainCurve, // <-- Add your curve here
                            ),
                          ),
                      child: Text(currentText, style: textTheme.titleLarge),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
