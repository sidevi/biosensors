import 'dart:math';
import '../models/patient.dart';
import '../models/reading.dart';

class MockDataService {
  static final Random _random = Random();

  // Generate a default patient with mock data
  static Patient getPatient() {
    final sensors = [
      Reading(
        sensorId: 'PTX-9842',
        name: 'PTX-9842',
        value: 14,
        unit: 'ms BLE',
        isBluetooth: true,
        statusText: 'SYNC 2x AGQ',
      ),
      Reading(
        sensorId: 'PATCH_A3',
        name: 'PATCH A3',
        value: 92,
        unit: '%',
        isBluetooth: true,
        statusText: 'SUB-Q B',
      ),
      Reading(
        sensorId: 'NODE_PUMP',
        name: 'NODE PUMP',
        value: 100,
        unit: '%',
        isInfusionActive: true,
        statusText: 'Infusion Active',
      ),
      Reading(
        sensorId: 'EPIDERMAL',
        name: 'Epidermal',
        value: 0,
        unit: '',
        statusText: 'Blossom',
      ),
    ];

    return Patient(
      name: 'Marcus Vance',
      age: 64,
      status: 'STABLE',
      closedLoopActive: true,
      syncProgress: 0.98,
      sensors: sensors,
      ecgWaveform: _generateEcgWaveform(200),
      heartRate: 74,
      hrv: 52,
      qtc: 412,
      drugLevel: 21.4,
      drugTargetMin: 18.0,
      drugTargetMax: 24.5,
      drugToxicThreshold: 35.0,
      drugClearanceHalfLife: 38.4,
      spo2: 98,
      systolicBP: 118,
      diastolicBP: 76,
      mapValue: 90,
      coreTemp: 36.8,
      respRate: 16,
      thermalStatus: 'Normothermic',
      respiratoryPattern: 'Regular',
      sentinelActive: true,
      sentinelMode: 'Anticonvulsants Mode',
      anomaliesInLast6h: 0,
      driftCheck: 0.02,
      algorithmStatus: 'Adaptive algorithm running in autonomous baseline mode.',
    );
  }

  // Update readings (simulate live data)
  static Patient updateReadings(Patient patient) {
    // Update ECG: shift and add new point
    final newEcg = List<double>.from(patient.ecgWaveform);
    newEcg.removeAt(0);
    newEcg.add(_generateEcgPoint());

    // Slightly vary vitals
    final newSpo2 = _clamp(patient.spo2 + _random.nextInt(3) - 1, 94, 100);
    final newHr = _clamp(patient.heartRate + _random.nextInt(5) - 2, 60, 90);
    final newSys = _clamp(patient.systolicBP + _random.nextInt(6) - 3, 100, 140);
    final newDia = _clamp(patient.diastolicBP + _random.nextInt(4) - 2, 60, 90);
    final newMap = _clamp(patient.mapValue + _random.nextInt(4) - 2, 80, 100);
    final newTemp = patient.coreTemp + (_random.nextDouble() - 0.5) * 0.1;
    final newResp = _clamp(patient.respRate + _random.nextInt(3) - 1, 12, 20);

    // Drug level drifts slowly
    final newDrug = patient.drugLevel + (_random.nextDouble() - 0.5) * 0.2;

    return Patient(
      name: patient.name,
      age: patient.age,
      status: patient.status,
      closedLoopActive: patient.closedLoopActive,
      syncProgress: patient.syncProgress,
      sensors: patient.sensors,
      ecgWaveform: newEcg,
      heartRate: newHr,
      hrv: _clamp(patient.hrv + _random.nextInt(4) - 2, 40, 70),
      qtc: _clamp(patient.qtc + _random.nextInt(6) - 3, 380, 450),
      drugLevel: newDrug,
      drugTargetMin: patient.drugTargetMin,
      drugTargetMax: patient.drugTargetMax,
      drugToxicThreshold: patient.drugToxicThreshold,
      drugClearanceHalfLife: patient.drugClearanceHalfLife,
      spo2: newSpo2,
      systolicBP: newSys,
      diastolicBP: newDia,
      mapValue: newMap,
      coreTemp: newTemp,
      respRate: newResp,
      thermalStatus: newTemp > 37.5 ? 'Warm' : (newTemp < 36.0 ? 'Cool' : 'Normothermic'),
      respiratoryPattern: 'Regular',
      sentinelActive: patient.sentinelActive,
      sentinelMode: patient.sentinelMode,
      anomaliesInLast6h: 0,
      driftCheck: 0.02 + (_random.nextDouble() - 0.5) * 0.01,
      algorithmStatus: patient.algorithmStatus,
    );
  }

  // Helper: clamp int
  static int _clamp(int value, int min, int max) {
    return value.clamp(min, max);
  }

  // ECG waveform generation: use sin + noise
  static List<double> _generateEcgWaveform(int count) {
    return List.generate(count, (_) => _generateEcgPoint());
  }

  static double _generateEcgPoint() {
    // Simulate a heartbeat: a combination of sine waves and spikes
    const double pi = 3.141592653589793;
    double t = DateTime.now().millisecondsSinceEpoch / 1000.0;
    double base = 2.0 * sin(2 * pi * 1.2 * t); // approximate heart rate
    // Add a sharper spike
    double spike = 0.0;
    double phase = (t * 1.2) % 1.0;
    if (phase < 0.05) {
      spike = 8.0 * (1 - phase / 0.05);
    } else if (phase < 0.1) {
      spike = -4.0 * ((phase - 0.05) / 0.05);
    }
    // Add noise
    double noise = (Random().nextDouble() - 0.5) * 0.5;
    return base + spike + noise;
  }
}