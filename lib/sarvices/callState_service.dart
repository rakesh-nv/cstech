import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modals/callStateModel.dart';

class CallStatusService {
  static const String _baseUrl = 'https://mock-api.calleyacd.com/api/list/68626fb697757cb741f449b9';

  static Future<CallStatusModel?> fetchCallStatus() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CallStatusModel.fromJson(data);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching call status: $e');
      return null;
    }
  }
}
