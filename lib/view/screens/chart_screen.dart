import 'package:cstech_test/controller/ChartScreen_controller.dart';
import 'package:cstech_test/sarvices/storageService.dart';
import 'package:cstech_test/view/auth/otp_verificaton_screen.dart';
import 'package:cstech_test/widgets/customButton.dart';
import 'package:cstech_test/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ChartScreen extends StatelessWidget {
  final controller = Get.put(ChartScreenController());

  //
  // Future<Map<String, String>> getCurrentUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? usersJson = prefs.getString('users');
  //   if (usersJson == null) return {'name': '', 'email': ''};
  //   List users = jsonDecode(usersJson);
  //   if (users.isEmpty) return {'name': '', 'email': ''};
  //   final user = users.last;
  //   return {'name': user['name'] ?? '', 'email': user['email'] ?? ''};
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: StorageService.getCurrentUser(),
      builder: (context, snapshot) {
        final name = snapshot.data?['name'] ?? '';
        final email = snapshot.data?['email'] ?? '';
        return Scaffold(
          drawer: CustomDrawer(name: name, email: email),
          appBar: AppBar(
            title: Text('Dashboard'),
            actions: [
              Icon(Icons.headset_mic),
              SizedBox(width: 16),
              Icon(Icons.notifications_none),
              SizedBox(width: 16),
            ],
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          body: Obx(
            () {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Test List Card
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Test List\n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${controller.pending.value + controller.done.value}',
                                    style: TextStyle(
                                      color: Colors.blueAccent.shade700,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'CALLS',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.blueAccent.shade700,
                              ),
                              child: Center(
                                child: Text(
                                  'S',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 40),
                    // Donut Chart
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: SizedBox(
                        width: 220,
                        height: 220,
                        child: CustomPaint(
                          painter: _CallStatsPainter(),
                        ),
                      ),
                    ),

                    SizedBox(height: 24),
                    // Legend with counts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _LegendItem(
                          color: Colors.orange,
                          label: 'Pending',
                          count: controller.pending.value,
                        ),
                        _LegendItem(
                          color: Colors.blue,
                          label: 'Done',
                          count: controller.done.value,
                        ),
                        _LegendItem(
                          color: Colors.purple,
                          label: 'Schedule',
                          count: controller.scheduled.value,
                        ),
                      ],
                    ),

                    SizedBox(height: 40),
                    // Button
                    CustomButton(
                      text: 'Start Calling Now',
                      onPressed: () {},
                    )
                  ],
                ),
              );
            },
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final int count;

  const _LegendItem({
    Key? key,
    required this.color,
    required this.label,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChartScreenController());

    return Container(
      height: 80,
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        child: Row(
          children: [
            Container(
              width: 5,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            SizedBox(width: 8),
            Container(
              child: controller.isLoading.value
                  ? CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.2),
                        ),
                        Row(
                          children: [
                            Text(
                              '$count',
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            Text(' Calls')
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallStatsPainter extends CustomPainter {
  final controller = Get.put(ChartScreenController());

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final startAngle = 180.0;
    final values = [
      controller.pending.value,
      controller.done.value,
      controller.scheduled.value,
    ];
    final colors = [Colors.orange, Colors.blue, Colors.purple];
    final total = values.reduce((a, b) => a + b);
    const gap = 6; // gap between segments in degrees

    double currentAngle = startAngle;
    for (int i = 0; i < values.length; i++) {
      final sweep = 360 * (values[i] / total) - gap;
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = (i == 2) ? 58 : 38 // thicker for purple segment
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(
        rect.deflate(10),
        radians(currentAngle),
        radians(sweep),
        false,
        paint,
      );
      currentAngle += sweep + gap;
    }
  }

  double radians(double degrees) => degrees * pi / 180;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
