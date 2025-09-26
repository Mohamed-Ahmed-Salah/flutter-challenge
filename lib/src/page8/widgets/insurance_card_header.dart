
import 'package:flutter/material.dart';
import 'package:flutter_challenge/config/size_const.dart';
import 'package:flutter_challenge/src/page8/model/insurance_plan_model.dart';
class InsuranceCardHeader extends StatelessWidget {
  final InsurancePlan plan;

  const InsuranceCardHeader({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
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
}
