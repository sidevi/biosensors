import 'reading.dart';

class Patient {
  final String name;
  final int age;
  final String status; // "STABLE", "CRITICAL", etc.
  final bool closedLoopActive;
  final double syncProgress; // 0.0 - 1.0
  final List<Reading> sensors;
  final List<double> ecgWaveform; // last 200 points
  final int heartRate;
  final int hrv;
  final int qtc;
  final double drugLevel; // mcg/mL
  final double drugTargetMin;
  final double drugTargetMax;
  final double drugToxicThreshold;
  final double drugClearanceHalfLife; // minutes
  final int spo2; // %
  final int systolicBP;
  final int diastolicBP;
  final int mapValue; // mmHg
  final double coreTemp; // °C
  final int respRate; // breaths/min
  final String thermalStatus; // "Normothermic", etc.
  final String respiratoryPattern; // "Regular", etc.
  final bool sentinelActive;
  final String sentinelMode;
  final int anomaliesInLast6h;
  final double driftCheck; // ±%
  final String algorithmStatus;

  Patient({
    required this.name,
    required this.age,
    required this.status,
    required this.closedLoopActive,
    required this.syncProgress,
    required this.sensors,
    required this.ecgWaveform,
    required this.heartRate,
    required this.hrv,
    required this.qtc,
    required this.drugLevel,
    required this.drugTargetMin,
    required this.drugTargetMax,
    required this.drugToxicThreshold,
    required this.drugClearanceHalfLife,
    required this.spo2,
    required this.systolicBP,
    required this.diastolicBP,
    required this.mapValue,
    required this.coreTemp,
    required this.respRate,
    required this.thermalStatus,
    required this.respiratoryPattern,
    required this.sentinelActive,
    required this.sentinelMode,
    required this.anomaliesInLast6h,
    required this.driftCheck,
    required this.algorithmStatus,
  });
}