import 'package:cstech_test/view/screens/home_screen.dart';
import 'package:get/get.dart';

import '../view/auth/otp_verificaton_screen.dart';
import '../view/auth/auth_screen.dart';
import '../view/screens/LanguageSelection_screen.dart';
import '../view/screens/chart_screen.dart';
import '../view/screens/dashBoard_screen.dart';

List<GetPage> appPages = [
  GetPage(name: '/', page: () => LanguageSelectionScreen()),
  GetPage(
    name: '/OtpVerificationScreen',
    page: () {
      final args = Get.arguments as Map<String, dynamic>;
      return OtpVerificationScreen(
        email: args['email'],
        name: args['name'],
        password: args['password'],
      );
    },
  ),
  GetPage(name: '/AuthScreen', page: () => AuthScreen()),
  GetPage(name: '/HomeScreen', page: () => HomeScreen()),
  GetPage(name: '/DashBoardScreen', page: () => DashBoardScreen()),
  GetPage(name: '/ChartScreen', page: () => ChartScreen())

];
