import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<Map<String, String>> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString('users');
    if (usersJson == null) return {'name': '', 'email': ''};
    List users = jsonDecode(usersJson);
    if (users.isEmpty) return {'name': '', 'email': ''};
    final user = users.last;
    return {'name': user['name'] ?? '', 'email': user['email'] ?? ''};
  }

  static Future<void> saveUser(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString('users');
    List users = usersJson != null ? jsonDecode(usersJson) : [];
    users.add({'name': name, 'email': email});
    if (users.length > 10) users = users.sublist(users.length - 10);
    prefs.setString('users', jsonEncode(users));
  }
  //
  // static Future<List<Map<String, String>>> getUsers() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? usersJson = prefs.getString('users');
  //   if (usersJson == null) return [];
  //   List users = jsonDecode(usersJson);
  //   return users
  //       .map<Map<String, String>>(
  //           (u) => {'name': u['name'], 'email': u['email']})
  //       .toList();
  // }
}
