import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  static Future<Map<String, dynamic>?> logHabit({
    required int userId,
    required String transportMode,
    required int plasticItemsAvoided,
    required double electricitySavedKwh,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/log-habit/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'transport_mode': transportMode,
          'plastic_items_avoided': plasticItemsAvoided,
          'electricity_saved_kwh': electricitySavedKwh,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Connection error: $e');
      return null;
    }
  }
}