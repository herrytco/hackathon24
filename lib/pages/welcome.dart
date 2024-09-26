import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
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
            ],
          );
        },
      ),
    );
  }
}
