import 'package:flutter/material.dart';
import '../models/patient.dart';

class DrugTitration extends StatelessWidget {
  final Patient patient;

  const DrugTitration({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final double min = patient.drugTargetMin;
    final double max = patient.drugTargetMax;
    final double toxic = patient.drugToxicThreshold;
    final double level = patient.drugLevel;

    // Normalize to 0..1 for bar placement
    final double range = toxic - 0; // assuming lower bound 0
    final double levelFraction = (level - 0) / range;
    final double minFraction = (min - 0) / range;
    final double maxFraction = (max - 0) / range;
    final double toxicFraction = (toxic - 0) / range;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SUB-Q DRUG TITRATION LEVEL',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade800,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'WITHIN WINDOW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Continuous Remifentanil Target Control',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '${patient.drugLevel.toStringAsFixed(1)} mcg/mL',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                'Target Range: ${min.toStringAsFixed(1)} – ${max.toStringAsFixed(1)}',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Bar with zones
          SizedBox(
            height: 30,
            child: Stack(
              children: [
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade300,
                        Colors.green,
                        Colors.yellow.shade700,
                        Colors.red,
                      ],
                      stops: [
                        minFraction / toxicFraction,
                        maxFraction / toxicFraction,
                        (maxFraction + 0.1) / toxicFraction,
                        1.0,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Marker for current level
                Positioned(
                  left: levelFraction * MediaQuery.of(context).size.width * 0.6,
                  top: -2,
                  child: Container(
                    width: 4,
                    height: 28,
                    color: Colors.white,
                  ),
                ),
                // Labels
                Positioned(
                  left: 0,
                  top: 22,
                  child: Text(
                    '0',
                    style: TextStyle(color: Colors.white54, fontSize: 10),
                  ),
                ),
                Positioned(
                  left: minFraction * MediaQuery.of(context).size.width * 0.6 - 8,
                  top: 22,
                  child: Text(
                    '${min.toStringAsFixed(1)} THERAPEUTIC',
                    style: TextStyle(color: Colors.white54, fontSize: 10),
                  ),
                ),
                Positioned(
                  left: toxicFraction * MediaQuery.of(context).size.width * 0.6 - 8,
                  top: 22,
                  child: Text(
                    '${toxic.toStringAsFixed(1)} TOXIC',
                    style: TextStyle(color: Colors.red, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text(
                '4H CLEARANCE SLOPE',
                style: TextStyle(color: Colors.white54, fontSize: 11),
              ),
              const SizedBox(width: 8),
              Text(
                't½: ${patient.drugClearanceHalfLife.toStringAsFixed(1)} min',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}