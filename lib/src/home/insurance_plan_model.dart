import 'package:flutter_challenge/config/media.dart';

class InsurancePlan {
  final String id;
  final String title;
  final String subtitle;
  final String
  type; // e.g. "High Deductible Health Plan", "Preferred Provider Org"
  final double rating; // e.g. 4.4
  final int matchPercentage; // e.g. 85
  final double pricePerMonth; // e.g. 133
  final String imageUrl;

  // Categories - 6 possible categories with enabled/disabled
  final Map<String, bool> categories;

  InsurancePlan({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.rating,
    required this.matchPercentage,
    required this.pricePerMonth,
    required this.imageUrl,
    required this.categories,
  });
}

final mockPlans = [
  InsurancePlan(
    id: "1",
    title: "CareFlex Saver",
    subtitle:
        "Best for your age and budget, with strong preventive care coverage and a low price.",
    type: "High Deductible Health Plan",
    rating: 4.4,
    matchPercentage: 85,
    pricePerMonth: 133,
    imageUrl: Media.blue,
    categories: {
      "Any Roo / ICU": true,
      "Annual check-up": true,
      "No co-pay": false,
      "Dental & vision": true,
      "2nd opinion": false,
      "100% renewal bonus": true,
    },
  ),
  InsurancePlan(
    id: "2",
    title: "WellPlus Freedom",
    subtitle:
        "Ideal for your travel schedule and pre-existing condition management.",
    type: "Preferred Provider Org",
    rating: 4.8,
    matchPercentage: 91,
    pricePerMonth: 263,
    imageUrl: Media.red,
    categories: {
      "Specialist access": true,
      "Online care 24/7": true,
      "Dental & vision": true,
      "Higher deductible": true,
      "2nd opinion": true,
      "HSA not supported": false,
    },
  ),
  InsurancePlan(
    id: "3",
    title: "BlueCare Essential",
    subtitle:
        "Best for your age and budget, with strong preventive care coverage and a low price.",
    type: "Health Maintenance Org",
    rating: 4.5,
    matchPercentage: 86,
    pricePerMonth: 220,
    imageUrl: Media.green,
    categories: {
      "Any Roo / ICU": true,
      "Annual check-up": true,
      "No co-pay": false,
      "Dental & vision": true,
      "2nd opinion": false,
      "100% renewal bonus": true,
    },
  ),
];
