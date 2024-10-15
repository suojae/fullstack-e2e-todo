import 'dart:convert';
import 'package:http/http.dart' as http;

class CounterService {
  final String baseUrl = 'http://192.168.10.120:3000';

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
