import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_challenge/config/colours.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/home/pages/page2.dart';
import 'package:flutter_challenge/src/home/widgets/page_sizer.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> with TickerProviderStateMixin {
  final FixedExtentScrollController _controller = FixedExtentScrollController(
    initialItem: 1,
  );

  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: 5);
  int _selectedAgeIndex = 5;
  int _selectedOptionIndex = 0;
  bool _isScrolling = false;
  final bool _isDragging = false;
  bool hasChangedInitialValue = false;
  bool _showFocusedAtTop = false;

  final List<String> options = [
    "Employed",
    "Freelancing / self-employed",
    "Unemployed",
    "Retired",
    "A student",
  ];

  late AnimationController _focusAnimationController;
  late AnimationController _animatorController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final List<int> numbers = List.generate(30, (i) => i + 1);

  // Global keys to track widget positions
  final GlobalKey _wheelKey = GlobalKey();
  final List<GlobalKey> _cardKeys = List.generate(5, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _focusAnimationController = AnimationController(
      duration: SizeConstants.duration,
      reverseDuration: Duration(milliseconds: 400),
      vsync: this,
    );
    _animatorController = AnimationController(
      duration: SizeConstants.duration,
      reverseDuration: Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1.4)).animate(
          CurvedAnimation(
            parent: _focusAnimationController,
            curve: Curves.easeInOutCubic,
          ),
        );

    _scaleAnimation = Tween<double>(begin: 0.2, end: 1).animate(
      CurvedAnimation(
        parent: _focusAnimationController,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _focusAnimationController.dispose();
    _animatorController.dispose();
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _startFocusAnimation() {
    setState(() {
      _showFocusedAtTop = true;
      hasChangedInitialValue = true;

    });
    _focusAnimationController.forward();

    _animatorController.forward();
  }

  void _resetFocusAnimation() {
    _focusAnimationController.reverse().then((_) {
      if (mounted) {
        setState(() {
          hasChangedInitialValue = true;
          _showFocusedAtTop = false;
        });
      }
    });
    _animatorController.reverse();
  }

  bool _isPointInSelectableCards(Offset globalPosition) {
    for (int i = 0; i < _cardKeys.length; i++) {
      final cardContext = _cardKeys[i].currentContext;
      if (cardContext != null) {
        final RenderBox cardBox = cardContext.findRenderObject() as RenderBox;
        final cardPosition = cardBox.localToGlobal(Offset.zero);
        final cardSize = cardBox.size;

        final cardRect = Rect.fromLTWH(
          cardPosition.dx,
          cardPosition.dy,
          cardSize.width,
          cardSize.height,
        );

        if (cardRect.contains(globalPosition)) {
          return true;
        }
      }
    }
    return false;
  }

  bool _isPointInWheelArea(Offset globalPosition) {
    final wheelContext = _wheelKey.currentContext;
    if (wheelContext != null) {
      final RenderBox wheelBox = wheelContext.findRenderObject() as RenderBox;
      final wheelPosition = wheelBox.localToGlobal(Offset.zero);
      final wheelSize = wheelBox.size;

      final wheelRect = Rect.fromLTWH(
        wheelPosition.dx,
        wheelPosition.dy,
        wheelSize.width,
        wheelSize.height,
      );

      return wheelRect.contains(globalPosition);
    }
    return false;
  }

  double _dragAccumulator = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return PageSize(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (TapDownDetails details) {
          // check taps: if tap landed inside a card, select card
          final pos = details.globalPosition;
          final isInWheel = _isPointInWheelArea(pos);
          final isInCards = _isPointInSelectableCards(pos);
          if (isInWheel && isInCards) {
            for (int i = 0; i < _cardKeys.length; i++) {
              final cardContext = _cardKeys[i].currentContext;
              if (cardContext != null) {
                final RenderBox cardBox =
                    cardContext.findRenderObject() as RenderBox;
                final cardPosition = cardBox.localToGlobal(Offset.zero);
                final cardSize = cardBox.size;

                final cardRect = Rect.fromLTWH(
                  cardPosition.dx,
                  cardPosition.dy,
                  cardSize.width,
                  cardSize.height,
                );

                if (cardRect.contains(pos)) {
                  setState(() {
                    // _isDragging = false;
                    _selectedOptionIndex = i;
                  });
                  return;
                }
              }
            }
          }

          // if tap inside wheel and NOT a card, prepare for dragging
          if (isInWheel && !isInCards) {
            // setState(() => _isDragging = true);
          }
        },
        onVerticalDragStart: (details) {
          print("onVerticalDragStart");
          final pos = details.globalPosition;
          final isInWheel = _isPointInWheelArea(pos);
          final isInCards = _isPointInSelectableCards(pos);

          if (isInWheel && !isInCards) {
            // setState(() => _isDragging = true);
            _dragAccumulator = 0.0;
          } else {
            // we tapped on card area -> don't start wheel dragging
            // setState(() => _isDragging = false);
          }
          print("ende onVerticalDragStart");
        },
        onVerticalDragUpdate: (DragUpdateDetails details) {
          if (!_isDragging) return;

          // _dragAccumulator += details.delta.dy;

          // convert pixels to item steps (itemExtent = 60)
          // const double itemExtent = 60.0;
          // int step = (_dragAccumulator / itemExtent).truncate();

          // if (step != 0) {
          //   final newIndex =
          //   (_selectedAgeIndex - step).clamp(0, numbers.length - 1);
          //   // Use jumpToItem for immediate reaction, animateToItem for smoothness.
          //   _scrollController.jumpToItem(newIndex);
          //   setState(() {
          //     _selectedAgeIndex = newIndex;
          //   });
          //   _dragAccumulator -= step * itemExtent;
          // }
        },
        onVerticalDragEnd: (details) {
          // if (!_isDragging) return;
          // setState(() => _isDragging = false);
          // center to nearest item smoothly
          // _scrollController.animateToItem(
          //   _selectedAgeIndex,
          //   duration: Duration(milliseconds: 200),
          //   curve: Curves.easeOut,
          // );
        },
        child: Stack(
          children: [
            // Wheel Section with conditional AbsorbPointer
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification) {
                  setState(() => _isScrolling = true);
                  if (_showFocusedAtTop) {
                    _resetFocusAnimation();
                  }
                } else if (notification is ScrollEndNotification) {
                  setState(() => _isScrolling = false);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (mounted) {
                      _startFocusAnimation();
                    }
                  });
                }
                return true;
              },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      key: _wheelKey,
                      child: ListWheelScrollView.useDelegate(
                        controller: _scrollController,
                        itemExtent: 60,
                        perspective: 0.003,
                        diameterRatio: 2,
                        physics: _isDragging
                            ? NeverScrollableScrollPhysics()
                            : const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedAgeIndex = index;
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: numbers.length,
                          builder: (context, index) {
                            final isSelected = index == _selectedAgeIndex;

                            return AnimatedBuilder(
                              animation: _focusAnimationController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: isSelected && _showFocusedAtTop
                                      ? _slideAnimation.value * 60
                                      : Offset.zero,
                                  child: AnimatedOpacity(
                                    opacity:
                                        !_isScrolling &&
                                            !isSelected &&
                                            hasChangedInitialValue
                                        ? 0
                                        : 1,
                                    duration: const Duration(milliseconds: 300),
                                    child: Container(
                                      width: mediaQuery.size.width * 0.8,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colours.whiteColor
                                            : Colours.whiteColor.withValues(
                                                alpha: 0.2,
                                              ),
                                        borderRadius: BorderRadius.circular(
                                          SizeConstants.innerBorderRadius,
                                        ),
                                      ),
                                      child: Center(
                                        child: AnimatedDefaultTextStyle(
                                          duration: Duration(
                                            milliseconds: SizeConstants
                                                .small300MilliSecondsDuration,
                                          ),
                                          style: TextStyle(
                                            fontSize:
                                                isSelected && _showFocusedAtTop
                                                ? 42
                                                : 36,
                                            fontWeight: isSelected
                                                ? FontWeight.w700
                                                : FontWeight.w500,
                                            color: isSelected
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey.withValues(
                                                    alpha: 0.2,
                                                  ),
                                            letterSpacing: 1.2,
                                          ),
                                          child: Text('${numbers[index]}'),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: SizedBox()),
                ],
              ),
            ),

            // Cards Section
            Column(
              children: [
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: !hasChangedInitialValue
                      ? SizedBox()
                      : AnimatedOpacity(
                          // opacity: 1,
                          opacity:
                              (_isScrolling && hasChangedInitialValue) ||
                                  !hasChangedInitialValue
                              ? 0
                              : 1,
                          duration: const Duration(milliseconds: 300),
                          child: AnimatedBuilder(
                            animation: _focusAnimationController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: !_isScrolling && _showFocusedAtTop
                                    ? _slideAnimation.value * 100
                                    : Offset.zero,
                                child: Column(
                                  children: [
                                    Text(
                                      "Are you currently...",
                                      style: theme.textTheme.titleMedium,
                                    ),

                                    ...options.asMap().entries.map((entry) {
                                      int index = entry.key;
                                      String value = entry.value;

                                      return SelectableCard(
                                            key: _cardKeys[index],
                                            text: value,
                                            isSelected:
                                                options[_selectedOptionIndex] ==
                                                value,
                                            onTap: () {
                                              setState(() {
                                                _selectedOptionIndex = index;
                                              });
                                            },
                                          )
                                          .animate(
                                            controller: _animatorController,
                                          )
                                          .slideY(
                                            duration:
                                                SizeConstants.durationSmall,
                                            curve: SizeConstants.mainCurve,
                                            begin: 0.5,
                                            delay: Duration(
                                              milliseconds: 120 * index,
                                            ),
                                          )
                                          .scale();
                                    }),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
