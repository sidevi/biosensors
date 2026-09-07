import 'package:flutter/material.dart';
import '../models/reading.dart';

class SensorCard extends StatelessWidget {
  final Reading reading;

  const SensorCard({super.key, required this.reading});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade700, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reading.name,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                reading.value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (reading.unit.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(
                  reading.unit,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (reading.isBluetooth)
                const Icon(Icons.bluetooth, color: Colors.blue, size: 14),
              if (reading.isInfusionActive)
                const Icon(Icons.arrow_upward, color: Colors.green, size: 14),
              const SizedBox(width: 4),
              Text(
                reading.statusText,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          if (reading.name.startsWith('PATCH') || reading.name.startsWith('NODE'))
            LinearProgressIndicator(
              value: reading.value / 100,
              backgroundColor: Colors.grey.shade700,
              valueColor: AlwaysStoppedAnimation<Color>(
                reading.value > 80 ? Colors.green : Colors.orange,
              ),
            ),
        ],
      ),
    );
  }
}