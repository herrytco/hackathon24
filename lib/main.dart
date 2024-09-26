import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/pages/welcome.dart';
import 'package:hackathon24/services/backend_service.dart';
import 'package:hackathon24/services/balance_service.dart';

void main() {
  GetIt.I.registerSingleton<BackendService>(BackendService());
  GetIt.I.registerSingleton<BalanceService>(BalanceService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WattUp!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}
