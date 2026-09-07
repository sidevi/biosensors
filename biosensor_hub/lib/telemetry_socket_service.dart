import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class TelemetrySocketService extends ChangeNotifier {
  io.Socket? _socket;
  final StreamController<Map<String, dynamic>> _telemetryController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get telemetryStream => _telemetryController.stream;
  bool isConnected = false;

  void connect(String baseUrl, String patientId) {
    _socket = io.io(
      baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket?.connect();

    _socket?.onConnect((_) {
      isConnected = true;
      notifyListeners();
      _socket?.emit('join_patient_room', {'patientId': patientId});
    });

    _socket?.on('telemetry_update', (data) {
      if (data != null && data is Map<String, dynamic>) {
        _telemetryController.add(data);
      }
    });

    _socket?.onDisconnect((_) {
      isConnected = false;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket?.dispose();
    _telemetryController.close();
  }
}
