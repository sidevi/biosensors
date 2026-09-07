import 'package:flutter/material.dart';
import '../models/patient.dart';
import 'sensor_card.dart';
import '../models/reading.dart';
class SensorMatrix extends StatelessWidget {
  final List<Reading> sensors;

  const SensorMatrix({super.key, required this.sensors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MULTI-SENSOR MATRIX',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: sensors.length,
          itemBuilder: (ctx, i) => SensorCard(reading: sensors[i]),
        ),
      ],
    );
  }
}