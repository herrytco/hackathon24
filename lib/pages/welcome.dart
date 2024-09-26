import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon24/component/welcome/balance_card.dart';
import 'package:hackathon24/component/welcome/drawer.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/services/balance_service.dart';
import 'package:hackathon24/pages/rewards.dart';

class _WelcomeData {
  int balance;

  _WelcomeData(this.balance);
}

Future<_WelcomeData> _loadData() async {
  int balance = GetIt.I.get<BalanceService>().balance;

  return _WelcomeData(balance);
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          backgroundColor: kelagGreen,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 50),
                    height: constraints.maxHeight,
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      "assets/logo_invers.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "WattUp!",
                        style: GoogleFonts.lato().copyWith(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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
      body: FutureBuilder<_WelcomeData>(
        future: _loadData(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          return Column(
            children: [
              BalanceCard(balance: data?.balance),
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
