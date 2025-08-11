// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/exceptions.dart';

class AuthService {
  final baseUrl = 'https://mock-api.calleyacd.com/api/auth';

  // register uset
  Future<Map<String, dynamic>> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    print(response.statusCode);

    final data = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return {"status": response.statusCode, "data": data};
      case 400:
        throw BadRequestException(data['message'] ?? 'Bad request');
      case 401:
        throw UnauthorizedException(data['message'] ?? 'Unauthorized');
      case 403:
        throw ForbiddenException(data['message'] ?? 'Forbidden');
      case 404:
        throw NotFoundException(data['message'] ?? 'Not found');
      case 500:
        throw InternalServerException('Server error');
      default:
        throw FetchDataException('Unexpected error: ${response.statusCode}');
    }
  }

  //  LOGIN uset
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return {"status": response.statusCode, "data": data};
      case 400:
        throw BadRequestException(data['message'] ?? 'Bad request');
      case 401:
        throw UnauthorizedException(data['message'] ?? 'Unauthorized');
      case 403:
        throw ForbiddenException(data['message'] ?? 'Forbidden');
      case 404:
        throw NotFoundException(data['message'] ?? 'Not found');
      case 500:
        throw InternalServerException('Server error');
      default:
        throw FetchDataException('Unexpected error: ${response.statusCode}');
    }
  }

//sending otp to gmail

  Future<bool> sendOtp({
    required String email,
  }) async {
    // print(email);
    final url = Uri.parse('$baseUrl/send-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    print('Status Code: ${response.statusCode}');
    print('Body: ${response.body}');
    switch (response.statusCode) {
      case 200:
        return true;
      case 400:
        throw BadRequestException('Bad request');
      case 401:
        throw UnauthorizedException('Unauthorized');
      case 403:
        throw ForbiddenException('Forbidden');
      case 404:
        throw NotFoundException('Not found');
      case 500:
        throw InternalServerException('Server error');
      default:
        throw FetchDataException('Unexpected error: ${response.statusCode}');
    }
  }

//  otp verigyotp
  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse('$baseUrl/verify-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );
    final data = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return {"status": response.statusCode, "data": data};
      case 400:
        throw BadRequestException(data['message'] ?? 'Bad request');
      case 401:
        throw UnauthorizedException(data['message'] ?? 'Unauthorized');
      case 403:
        throw ForbiddenException(data['message'] ?? 'Forbidden');
      case 404:
        throw NotFoundException(data['message'] ?? 'Not found');
      case 500:
        throw InternalServerException('Server error');
      default:
        throw FetchDataException('Unexpected error: ${response.statusCode}');
    }
  }
}
