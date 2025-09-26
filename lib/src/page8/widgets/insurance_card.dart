import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/page8/model/insurance_plan_model.dart';
import 'package:flutter_challenge/src/page8/widgets/circular_indicator.dart';
import 'package:flutter_challenge/src/page8/widgets/insurance_card_header.dart';

import 'insurance_card_features.dart';

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
          InsuranceCardHeader(plan: plan),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeConstants.innerContainerPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
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
                  const SizedBox(height: SizeConstants.verticalSpace),
                  InsuranceCardFeatures(plan: plan),
                  _DetailsButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsButton extends StatelessWidget {
  const _DetailsButton();

  @override
  Widget build(BuildContext context) {
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
