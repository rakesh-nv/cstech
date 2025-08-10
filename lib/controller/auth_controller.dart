import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../sarvices/auth_service.dart';
import '../view/screens/home_screen.dart';
import '../utils/exceptions.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();

  var isLoading = false.obs;
  var isLogin = true.obs;
  var obscurePassword = false.obs;
  var agreeToTerms = false.obs;

  void toggleAuthMode() {
    isLogin.value = !isLogin.value;
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleTermsAgreement(bool? value) {
    agreeToTerms.value = value ?? false;
  }

  Future<void> submitLogin() async {
    if (!signInFormKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final result = await _authService.loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final status = result['status'];
      final data = result['data'];

      print('Login Status: $status');
      print('Login Data: ' + data.toString());

      if (status == 200) {
        Get.snackbar("Success", data['message'] ?? "Logged in successfully",
            snackPosition: SnackPosition.TOP);
        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar("Error", data['message'] ?? "Login failed",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } on AppException catch (e) {
      Get.snackbar("Error", e.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "An error occurred. Please try again.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> startOtpVerification() async {
    if (!signUpFormKey.currentState!.validate()) return;

    if (!agreeToTerms.value) {
      Get.snackbar("Error", "You must agree to the Terms and Conditions.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final registrationResult = await _authService.registerUser(
        username: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final regStatus = registrationResult["status"];
      final regData = registrationResult["data"];

      if (regStatus == 200 || regStatus == 201) {
        final otpSent = await _authService.sendOtp(email: emailController.text.trim());
        print(otpSent);
        if (otpSent) {
          Get.snackbar("OTP Sent", "OTP has been sent to your email", snackPosition: SnackPosition.TOP);
          Get.toNamed('/OtpVerificationScreen', arguments: {
            'email': emailController.text.trim(),
            'name': nameController.text.trim(),
            'password': passwordController.text.trim(),
          });
        } else {
          Get.snackbar("Error", "Failed to send OTP",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", regData['message'] ?? "Registration failed",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } on AppException catch (e) {
      Get.snackbar("Error", e.message,
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to register or send OTP.",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    try {
      final result = await _authService.verifyOtp(email: email, otp: otp);

      return result['status'] == 200;
    } on AppException catch (e) {
      Get.snackbar("Error", e.message, backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } catch (e) {
      Get.snackbar("Error", "OTP Verification failed.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    try {
      final result = await _authService.registerUser(
        username: name,
        email: email,
        password: password,
      );

      final status = result['status'];
      final data = result['data'];

      if (status == 200 || status == 201) {
        Get.snackbar("Success", data['message'] ?? "Registered successfully");
        Get.offAll(() => HomeScreen());
        return true;
      } else {
        Get.snackbar("Error", data['message'] ?? "Registration failed",
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } on AppException catch (e) {
      Get.snackbar("Error", e.message,
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } catch (e) {
      Get.snackbar("Error", "Registration error.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
