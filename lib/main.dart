import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/pages/reservation.dart';
import 'package:hackathon24/pages/welcome.dart';
import 'package:hackathon24/services/backend_service.dart';
import 'package:hackathon24/services/balance_service.dart';
import 'package:hackathon24/services/chargepoint_service.dart';

extension ColorsExt on Color {
  MaterialColor toMaterialColor() {
    final int red = this.red;
    final int green = this.green;
    final int blue = this.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(value, shades);
  }
}

void main() {
  GetIt.I.registerSingleton<BackendService>(BackendService());
  GetIt.I.registerSingleton<BalanceService>(BalanceService());
  GetIt.I.registerSingleton<ChargePointService>(ChargePointService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WattUp!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kelagGreen.toMaterialColor(),
        ),
        useMaterial3: true,
      ),
      routes: {
        "/": (_) => const WelcomePage(),
        "/reservations": (_) => const ReservationPage(),
      },
      initialRoute: "/reservations",
    );
  }
}
