import 'package:cstech_test/routs/appPages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CALLEY',
      debugShowCheckedModeBanner: false,
      getPages:appPages,
    );
  }
}
