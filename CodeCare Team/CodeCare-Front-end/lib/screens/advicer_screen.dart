import 'package:flutter/material.dart';

class HealthAdviceScreen extends StatelessWidget {
  const HealthAdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> healthTips = [

      {
        "title": "Stay Hydrated",
        "advice": "Drink at least 6–8 glasses of water daily to keep your body hydrated.",
        "icon": "water"
      },

      {
        "title": "Eat Healthy",
        "advice": "Include fruits, vegetables, and whole grains in your daily meals.",
        "icon": "food"
      },

      {
        "title": "Exercise Regularly",
        "advice": "Try to exercise for at least 30 minutes every day.",
        "icon": "exercise"
      },

      {
        "title": "Get Enough Sleep",
        "advice": "Adults should sleep 7–9 hours each night for better health.",
        "icon": "sleep"
      },

      {
        "title": "Manage Stress",
        "advice": "Practice relaxation techniques like deep breathing or meditation.",
        "icon": "mental"
      },

      {
        "title": "Take Your Medication",
        "advice": "Always follow the instructions given by your healthcare provider.",
        "icon": "medicine"
      }

    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Advice"),
        backgroundColor: const Color(0xFF1F6F68),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: healthTips.length,
        itemBuilder: (context, index) {

          final tip = healthTips[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            child: ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Color(0xFF1F6F68),
                size: 35,
              ),

              title: Text(
                tip["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(tip["advice"]!),
              ),
            ),
          );
        },
      ),
    );
  }
}