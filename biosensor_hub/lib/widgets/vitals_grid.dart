import 'package:flutter/material.dart';
import '../models/patient.dart';

class VitalsGrid extends StatelessWidget {
  final Patient patient;

  const VitalsGrid({super.key, required this.patient});

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
          const Text(
            'VITALS',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.8,
            children: [
              _VitalCard(
                label: 'SpO2',
                value: '${patient.spo2}%',
                icon: Icons.air,
                color: Colors.blue,
              ),
              _VitalCard(
                label: 'CBP (PTT)',
                value: '${patient.systolicBP}/${patient.diastolicBP} mmHg',
                icon: Icons.favorite,
                color: Colors.red,
              ),
              _VitalCard(
                label: 'MAP Value',
                value: '${patient.mapValue} mmHg',
                icon: Icons.speed,
                color: Colors.orange,
              ),
              _VitalCard(
                label: 'CORE TEMP',
                value: '${patient.coreTemp.toStringAsFixed(1)}°C',
                icon: Icons.thermostat,
                color: Colors.amber,
                subtext: patient.thermalStatus,
              ),
              _VitalCard(
                label: 'RESP RATE',
                value: '${patient.respRate} br/min',
                icon: Icons.air,
                color: Colors.teal,
                subtext: patient.respiratoryPattern,
              ),
              _VitalCard(
                label: 'Thermal Norm',
                value: patient.thermalStatus,
                icon: Icons.straighten,
                color: Colors.green,
                subtext: 'Normothermic',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VitalCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtext;

  const _VitalCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtext != null)
                Text(
                  subtext!,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 9,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}