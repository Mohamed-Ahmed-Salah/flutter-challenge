
import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/page8/model/insurance_plan_model.dart';
class InsuranceCardFeatures extends StatelessWidget {
  final InsurancePlan plan;

  const InsuranceCardFeatures({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
