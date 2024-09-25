import 'package:flutter/material.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const IconButton(onPressed: null, icon: Icon(Icons.menu)),
          title: const Text('Rewards')),
      body: const Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
