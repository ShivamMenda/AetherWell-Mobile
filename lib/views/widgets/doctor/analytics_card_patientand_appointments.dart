import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final IconData icon;
  final String header;
  final String subheader;
  final Color iconColor;
  final Color headerColor;
  final Color subheaderColor;
  final double iconSize;

  const CustomCardWidget({
    Key? key,
    required this.icon,
    required this.header,
    required this.subheader,
    this.iconColor = Colors.orange,
    this.headerColor = Colors.blueGrey,
    this.subheaderColor = Colors.white70,
    this.iconSize = 40.0, // Increased icon size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Increased padding here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
            SizedBox(height: 16), // Increased height here
            Text(
              header,
              style: TextStyle(
                color: headerColor,
                fontSize: 22, // Increased font size here
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), // Increased height here
            Text(
              subheader,
              style: TextStyle(
                color: subheaderColor,
                fontSize: 18, // Increased font size here
              ),
            ),
          ],
        ),
      ),
    );
  }
}


