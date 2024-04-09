import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class UserRecommendationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User recommendation'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text(
          'User Recommendation',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}