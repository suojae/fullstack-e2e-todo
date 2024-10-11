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

  Future<int> getCounter() async {
    final response = await http.get(Uri.parse('$baseUrl/counter'));
    if (response.statusCode == 200) {
      final value = json.decode(response.body);
      return value as int;
    } else {
      throw Exception('Failed to load counter');
    }
  }

  Future<void> incrementCounter() async {
    final response = await http.post(Uri.parse('$baseUrl/counter/increment'));
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to increment counter');
    }
  }
}
