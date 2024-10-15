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
    _loadInitialCounter();
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
      final updatedCounter = await _counterService.getCounter();
      _counterController.add(updatedCounter);
    } catch (e) {
      _counterController.addError('Failed to increment counter: $e');
    }
  }

  @override
  void dispose() {
    _counterController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Sync without Socket',
      home: Scaffold(
        appBar: AppBar(title: Text('Counter Sync without Socket')),
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
