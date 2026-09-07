import 'package:flutter/material.dart';
import '../models/patient.dart';

class SentinelPanel extends StatelessWidget {
  final Patient patient;

  const SentinelPanel({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade700, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: patient.sentinelActive ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'SENTINEL PROTOCOL ACTIVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            patient.sentinelMode,
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            'Zero critical physiological anomalies detected in past 6h.',
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
          const SizedBox(height: 2),
          Text(
            patient.algorithmStatus,
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Drift Check:',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(width: 8),
              Text(
                '±${patient.driftCheck.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: patient.driftCheck.abs() < 0.05 ? Colors.green : Colors.orange,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Trigger calibration (mock)
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text('RUN SENSOR CALIBRATION'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}