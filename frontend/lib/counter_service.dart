import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CounterService {
  final String baseUrl = 'http://192.168.10.120:3000';
  late IO.Socket socket;

  void Function(int)? onCounterUpdated;

  CounterService() {
    socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
    });
  }

  void connect() {
    socket.on('connect', (_) {
      print('Connected to WebSocket server');
    });

    socket.on('counterUpdated', (data) {
      print('Counter updated: $data');
      onCounterUpdated?.call(data as int); // Use null-aware operator
    });

    socket.on('disconnect', (_) {
      print('Disconnected from WebSocket server');
    });
  }

// Rest of your code...
}
