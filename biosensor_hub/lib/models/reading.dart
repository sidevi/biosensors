class Reading {
  final String sensorId;
  final String name;
  final double value;
  final String unit;
  final bool isBluetooth;
  final bool isInfusionActive;
  final String statusText; // e.g. "Bluetooth", "Infusion Active"

  Reading({
    required this.sensorId,
    required this.name,
    required this.value,
    required this.unit,
    this.isBluetooth = false,
    this.isInfusionActive = false,
    this.statusText = '',
  });
}