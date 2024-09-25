import 'package:flutter/material.dart';
import 'package:hackathon24/constants/theme_data.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kelagGreen,
        title: Row(
          children: [
            Container(
              width: 100,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
