import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CallStatusCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final Color textColor;

  const CallStatusCard({
    required this.label,
    required this.count,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor)),
          Text('$count',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }
}
