import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      backgroundColor: Color(0xFFF4F7FF),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: Color(0xFF2563EB),
            padding: EdgeInsets.only(top: 40, left: 20, bottom: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "• Personal",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildMenuItem(Icons.play_circle_outline, "Getting Started"),
          _buildMenuItem(Icons.sync, "Sync Data"),
          _buildMenuItem(Icons.emoji_events_outlined, "Gamification"),
          _buildMenuItem(Icons.send_to_mobile_outlined, "Send Logs"),
          _buildMenuItem(Icons.settings_outlined, "Settings"),
          _buildMenuItem(Icons.help_outline, "Help?"),
          _buildMenuItem(Icons.cancel_outlined, "Cancel Subscription"),
          Divider(height: 24, thickness: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              "App Info",
              style: TextStyle(
                color: Color(0xFF2563EB),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          _buildMenuItem(Icons.info_outline, "About Us"),
          _buildMenuItem(Icons.privacy_tip_outlined, "Privacy Policy"),
          _buildMenuItem(Icons.verified_outlined, "Version 1.01.52"),
          _buildMenuItem(Icons.share_outlined, "Share App"),
          _buildMenuItem(Icons.logout, "Logout"),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: SizedBox(
        height: 55,
        child: ListTile(
          leading: SizedBox(
            width: 60,
            height: 40,
            child: Card(
              color: Colors.white,
              elevation: 1,
              child: Icon(icon, color: Colors.black87, size: 20),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
          onTap: () async {
            if (title == "Logout") {
              Get.back();
              Get.offAllNamed('/AuthScreen');
            }
          },
        ),
      ),
    );
  }
}
