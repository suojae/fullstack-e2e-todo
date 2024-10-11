import 'dart:async';
import 'package:flutter/material.dart';
import 'counter_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterService _counterService = CounterService();
  final StreamController<int> _counterController = StreamController<int>();

  @override
  void initState() {
    super.initState();
    _counterService.onCounterUpdated = (value) {
      _counterController.add(value);
    };
    _counterService.connect();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
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
      // Counter will be updated via WebSocket
    } catch (e) {
      _counterController.addError('Failed to increment counter: $e');
    }
  }

  @override
  void dispose() {
    _counterService.disconnect();
    _counterController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
