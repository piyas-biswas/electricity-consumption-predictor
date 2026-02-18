import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Replace this with your Flask API URL
  final String apiUrl = 'http://192.168.0.2:5050/predict';

  /// Sends input data to the API and returns the predicted value
  Future<double?> getPrediction({
    required double voltage,
    required double sub1,
    required double sub2,
    required double sub3,
    required int hour,
    required int dayOfWeek,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "Voltage": voltage,
          "Sub_metering_1": sub1,
          "Sub_metering_2": sub2,
          "Sub_metering_3": sub3,
          "hour": hour,
          "day_of_week": dayOfWeek,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['prediction'];
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
