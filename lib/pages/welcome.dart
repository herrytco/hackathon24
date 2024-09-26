import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon24/component/header.dart';
import 'package:hackathon24/component/welcome/balance_card.dart';
import 'package:hackathon24/component/welcome/drawer.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/model/app_state.dart';
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

  void selectDrawer(int selected, BuildContext context) {
    setState(() {
      selectedDrawer = selected;
      Navigator.pop(context);
      if (selected == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RewardsPage()),
        );
      }
    });
  }

  Future<void> _onCharge() async {
    await GetIt.I.get<BalanceService>().addBalance(Random().nextInt(1000));

    setState(() {});
  }

  void _onReservation() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ReservationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KelagAppHeader.header,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onReservation,
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

          return Column(
            children: [
              BalanceCard(balance: data),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _onCharge,
                    label: const Text("Laden"),
                    icon: const Icon(Icons.battery_charging_full_sharp),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
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
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    zoom: 15,
                    target: LatLng(
                      46.6106852,
                      13.8097518,
                    ),
                  ),
                  markers: {
                    const Marker(
                      markerId: MarkerId("myPosition"),
                      position: LatLng(
                        46.6106852,
                        13.8097518,
                      ),
                    ),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
