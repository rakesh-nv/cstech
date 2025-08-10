import 'package:cstech_test/controller/auth_controller.dart';
import 'package:cstech_test/sarvices/storageService.dart';
import 'package:cstech_test/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cstech_test/widgets/customButton.dart';

import '../../sarvices/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final String name;
  final String password;

  const OtpVerificationScreen({
    Key? key,
    required this.email,
    required this.name,
    required this.password,
  }) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final AuthService _authService = AuthService();
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final authController = Get.put(AuthController());

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 48,
      height: 48,
      child: TextField(
        controller: _otpControllers[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (val) {
          if (val.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (val.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  // // Helper to save up to 10 users
  // Future<void> saveUser(String name, String email) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? usersJson = prefs.getString('users');
  //   List users = usersJson != null ? jsonDecode(usersJson) : [];
  //   users.add({'name': name, 'email': email});
  //   if (users.length > 10) users = users.sublist(users.length - 10);
  //   prefs.setString('users', jsonEncode(users));
  // }

  // Helper to get users
  Future<List<Map<String, String>>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString('users');
    if (usersJson == null) return [];
    List users = jsonDecode(usersJson);
    return users.map<Map<String, String>>((u) => {'name': u['name'], 'email': u['email']}).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/img1.png', // replace with your logo path
                    height: 60,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade600),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Whatsapp OTP\nVerification',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Please enter the OTP sent to:\n${widget.email}',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) => otpBox(index)),
                      ),
                      const SizedBox(height: 210),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Didn't receive OTP code? "),
                          GestureDetector(
                            onTap: () async {
                              await _authService.sendOtp(email: widget.email);
                              Get.snackbar("OTP Resent",
                                  "A new OTP has been sent to your email.",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white);
                            },
                            child: const Text(
                              'Resend OTP',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      CustomButton(
                        text: 'Verify',
                        onPressed: () async {
                          String otp =
                              _otpControllers.map((c) => c.text.trim()).join();

                          if (otp.length != 6) {
                            Get.snackbar(
                                "Invalid OTP", "Please enter the 6-digit OTP",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                            return;
                          }
                          bool otpValid =
                              await authController.verifyOtp(widget.email, otp);

                          if (otpValid) {
                            var name = authController.nameController.text.trim();
                            var email = authController.emailController.text.trim();
                            await StorageService.saveUser(name, email);
                            Get.offAll(() => HomeScreen());
                          } else {
                            Get.snackbar(
                              "Invalid OTP",
                              "Please check and try again",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
