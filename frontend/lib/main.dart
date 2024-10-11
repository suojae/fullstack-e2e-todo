import 'dart:async';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'counter_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterService _counterService = CounterService();
  final StreamController<int> _counterController = StreamController<int>();
  late IO.Socket _socket;

  @override
  void initState() {
    super.initState();
    _connectSocket();
    _loadInitialCounter();
  }

  void _connectSocket() {
    _socket = IO.io('http://192.168.10.120:3000', <String, dynamic>{
      'transports': ['websocket'],
    });

    _socket.on('connect', (_) {
      print('Connected to WebSocket server');
    });

    _socket.on('counterUpdated', (data) {
      print('Counter updated: $data');
      _counterController.add(data as int);
    });

    _socket.on('disconnect', (_) {
      print('Disconnected from WebSocket server');
    });
  }

  Future<void> _loadInitialCounter() async {
    try {
      final counter = await _counterService.getCounter();
      _counterController.add(counter);
    } catch (e) {
      _counterController.addError('Failed to load counter: $e');
    }
  }

  Future<void> _incrementCounter() async {
    try {
      await _counterService.incrementCounter();
      // The counter will update via WebSocket
    } catch (e) {
      _counterController.addError('Failed to increment counter: $e');
    }
  }

  @override
  void dispose() {
    _socket.disconnect();
    _counterController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Sync with Stream',
      home: Scaffold(
        appBar: AppBar(title: Text('Counter Sync with Stream')),
        body: Center(
          child: StreamBuilder<int>(
            stream: _counterController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Counter: ${snapshot.data}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: Text('Increment Counter'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
