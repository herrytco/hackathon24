import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon24/component/charge_point_map.dart';
import 'package:hackathon24/component/header.dart';
import 'package:hackathon24/component/welcome/balance_card.dart';
import 'package:hackathon24/component/welcome/drawer.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/model/app_state.dart';
import 'package:hackathon24/model/chargepoint.dart';
import 'package:hackathon24/pages/gamble.dart';
import 'package:hackathon24/pages/history.dart';
import 'package:hackathon24/pages/reservation.dart';
import 'package:hackathon24/services/balance_service.dart';
import 'package:hackathon24/pages/rewards.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  int selectedDrawer = 0;
  bool dailyGoalReached = false;
  AppState? currentState;

  final _confettiController = ConfettiController(
    duration: const Duration(seconds: 1),
  );

  void selectDrawer(int selected, BuildContext context) {
    setState(() {
      selectedDrawer = selected;
      Navigator.pop(context);

      switch (selected) {
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PopScope(
                onPopInvokedWithResult: (didpop, dynamic) {
                  setState(() {});
                },
                child: const HistoryPage(),
              ),
            ),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PopScope(
                onPopInvokedWithResult: (didpop, dynamic) {
                  setState(() {});
                },
                child: const GamblePage(),
              ),
            ),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PopScope(
                onPopInvokedWithResult: (didpop, dynamic) {
                  setState(() {});
                },
                child: const RewardsPage(),
              ),
            ),
          );
          break;
      }
    });
  }

  Future<void> _onCharge(int oldStreakValue) async {
    await GetIt.I.get<BalanceService>().addBalance(Random().nextInt(1000));
    if (!dailyGoalReached) {
      await GetIt.I.get<BalanceService>().increaseStreak();
    }
    setState(() {
      dailyGoalReached = true;
      if (oldStreakValue + 1 == BalanceService.maxStreakValue) {
        _confettiController.play();
      }
    });
  }

  void _onReservation(ChargePoint? chargePoint) {
    if (currentState == null) return;
    chargePoint ??= currentState!.chargePoints.first;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReservationPage(
          chargePoint: chargePoint,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KelagAppHeader.header,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onReservation(null),
        icon: const Icon(Icons.book, color: Colors.white),
        label: const Text(
          "Jetzt Ladestation reservieren",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: kelagGreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      drawer: WelcomeDrawer(
        selectedDrawer: selectedDrawer,
        selectDrawer: (value) => selectDrawer(value, context),
      ),
      body: FutureBuilder<AppState>(
        future: loadAppState(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          currentState = data;

          return ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 50,
            child: Column(
              children: [
                BalanceCard(
                  balance: data,
                  reload: () {
                    setState(() {});
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _onCharge(data!.streak),
                      label: const Text("Laden"),
                      icon: const Icon(Icons.battery_charging_full_sharp),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HistoryPage()),
                      ),
                      label: const Text("Ladehistorie"),
                      icon: const Icon(Icons.history),
                    ),
                  ],
                ),
                const Gap(16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Divider(),
                ),
                const Gap(16),
                Expanded(
                  child: snapshot.data != null
                      ? ChargePointMap(
                          state: snapshot.data!,
                          controller: _controller,
                          onSelect: (ChargePoint point) =>
                              _onReservation(point),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
