import 'package:flutter/material.dart';
import 'patient_monitor_screen.dart';

// Use 10.0.2.2 for Android Emulator, or your local LAN IP (e.g., http://192.168.1.X:3000) for physical devices
const String backendUrl = 'http://10.0.2.2:3000';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biosensor Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PatientMonitorScreen(
        patientId: '30b74e5c-c228-4ec6-9ccf-07390ffeb5d8',
        baseUrl: backendUrl,
      ),
    );
  }
}
