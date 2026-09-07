import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'telemetry_socket_service.dart';

class PatientMonitorScreen extends StatefulWidget {
  final String patientId;
  final String baseUrl;

  const PatientMonitorScreen({
    super.key,
    required this.patientId,
    required this.baseUrl,
  });

  @override
  State<PatientMonitorScreen> createState() => _PatientMonitorScreenState();
}

class _PatientMonitorScreenState extends State<PatientMonitorScreen> {
  late TelemetrySocketService _socketService;

  @override
  void initState() {
    super.initState();
    _socketService = TelemetrySocketService();
    _socketService.connect(widget.baseUrl, widget.patientId);
  }

  @override
  void dispose() {
    _socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _socketService,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Live Bio-Telemetry Monitor'),
          actions: [
            Consumer<TelemetrySocketService>(
              builder: (_, service, __) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.circle,
                  color: service.isConnected ? Colors.green : Colors.red,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        body: StreamBuilder<Map<String, dynamic>>(
          stream: _socketService.telemetryStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Waiting for live telemetry signals...'),
                  ],
                ),
              );
            }

            final payload = snapshot.data!;
            final data = payload['data'] as Map<String, dynamic>? ?? {};
            final heartRate = data['heartRate'] ?? 0;
            final spo2 = data['spo2'] ?? 0;
            final ecgValue = data['ecgValue'] ?? 0.0;
            final isAnomaly = payload['anomalyFlag'] == true;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (isAnomaly)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      color: Colors.red.shade100,
                      child: const Row(
                        children: [
                          Icon(Icons.warning, color: Colors.red),
                          SizedBox(width: 8),
                          Text('ANOMALY DETECTED IN PATIENT READINGS',
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  _MetricCard(
                    title: 'Heart Rate',
                    value: '$heartRate BPM',
                    icon: Icons.favorite,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 12),
                  _MetricCard(
                    title: 'SpO2 Level',
                    value: '$spo2%',
                    icon: Icons.water_drop,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _MetricCard(
                    title: 'ECG Signal',
                    value: '$ecgValue mV',
                    icon: Icons.show_chart,
                    color: Colors.green,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: color, size: 36),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(
          value,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}
