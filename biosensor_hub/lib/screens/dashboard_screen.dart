import 'package:flutter/material.dart';
import 'dart:async';
import '../models/patient.dart';
import '../services/mock_data_service.dart';
import '../widgets/patient_header.dart';
import '../widgets/sensor_matrix.dart';
import '../widgets/ecg_chart.dart';
import '../widgets/drug_titration.dart';
import '../widgets/vitals_grid.dart';
import '../widgets/sentinel_panel.dart';
import '../widgets/bottom_nav.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Patient _patient;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _patient = MockDataService.getPatient();
    // Update every 2 seconds to simulate live data
    _timer = Timer.periodic(const Duration(seconds: 2), (t) {
      setState(() {
        _patient = MockDataService.updateReadings(_patient);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PatientHeader(patient: _patient),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  SensorMatrix(sensors: _patient.sensors),
                  const SizedBox(height: 16),
                  EcgChart(patient: _patient),
                  const SizedBox(height: 16),
                  DrugTitration(patient: _patient),
                  const SizedBox(height: 16),
                  VitalsGrid(patient: _patient),
                  const SizedBox(height: 16),
                  SentinelPanel(patient: _patient),
                  const SizedBox(height: 80), // space for bottom nav
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}