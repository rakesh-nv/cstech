import 'package:cstech_test/sarvices/callState_service.dart';
import 'package:cstech_test/sarvices/storageService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../widgets/customDrawer.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String,String>>(
      future: StorageService.getCurrentUser(),
      builder: ( context,  snapshot) {
        final name = snapshot.data?['name']??'';
        final email = snapshot.data?['email']??'';
        return  Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          drawer: CustomDrawer(name: name, email: email,),

          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Dashboard',
              style: const TextStyle(color: Colors.black),
            ),
            actions: const [
              Icon(Icons.headphones, color: Colors.black),
              SizedBox(width: 16),
              Icon(Icons.notifications_none, color: Colors.black),
              SizedBox(width: 16),
            ],
            iconTheme: const IconThemeData(color: Colors.black),
          ),

          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A73E8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Hello Swati',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            'Welcome to Calley!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      // Blue Header Container
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF1A237E),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        height: 400,
                      ),

                      // Title Text Positioned at Top Center
                      const Positioned(
                        top: 16,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'LOAD NUMBER TO CALL',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // Red Content Container Positioned Below Header Title
                      Positioned(
                        top: 50,
                        // Adjust this based on spacing needs
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(16),
                                top: Radius.circular(16)),
                          ),
                          // padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: const Text.rich(
                                  TextSpan(
                                    text: 'Visit ',
                                    children: [
                                      TextSpan(
                                        text: 'https://app.getcalley.com',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      TextSpan(
                                        text:
                                        ' to upload numbers that you wish to call using Calley Mobile App.',
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 160,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          // color: Colors.blue,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/img.png',
                            height: 350,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),
              // WhatsApp and Start Calling buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(FontAwesomeIcons.whatsapp,
                          color: Colors.green),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          _bottomSheet();
                        },
                        child: const Text(
                          'Star Calling Now',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          // Bottom navigation bar
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 1,
            selectedItemColor: const Color(0xFF1A73E8),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_fill),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.phone_forwarded_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                label: '',
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        );
      },

    );
  }

  Future _bottomSheet() {
    return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [
            Container(
              height: 270,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueAccent.shade700,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 130, vertical: 10),
                child: Text(
                  'Calling List',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                height: 230,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: Column(
                    children: [
                      // Select Calling List + Refresh Button
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Select Calling List",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Refresh logic here
                              },
                              icon: const Icon(
                                Icons.refresh,
                                size: 16,
                                color: Colors.white,
                              ),
                              label: const Text("Refresh"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xFF1A73E8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Calling List Item
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Test List",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                                onTap: () {
                                  Get.toNamed('ChartScreen');
                                  CallStatusService.fetchCallStatus();
                                },
                                child: const Icon(Icons.arrow_forward_ios)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
