import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_challenge/src/page8/model/insurance_plan_model.dart';
import 'package:flutter_challenge/src/home/widgets/page_sizer.dart';

import 'widgets/insurance_card.dart';

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
          SizedBox(
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

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    return true;
  }
}
