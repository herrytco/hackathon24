import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/services/activated_service.dart';
import 'package:hackathon24/services/balance_service.dart';
import 'package:hackathon24/model/app_state.dart';
import 'package:hackathon24/component/welcome/balance_card.dart';
import 'package:hackathon24/component/rewards/reward_item.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<StatefulWidget> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  Future<void> _reduceBalance(int cost, String id) async {
    bool isAffordable = GetIt.I.get<BalanceService>().balance > cost;
    bool isActivated = GetIt.I.get<ActivatedService>().isActivated(id);
    if (isAffordable && !isActivated) {
      await GetIt.I.get<BalanceService>().removeBalance(cost);
      GetIt.I.get<ActivatedService>().activate(id);

      setState(() {});
    } else if (isActivated) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Diese Prämie wurde schon aktiviert"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Zu wenige Kelax"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rewards')),
      body: FutureBuilder<AppState>(
        future: loadAppState(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          return SingleChildScrollView(
              child: Column(
            children: [
              BalanceCard(
                balance: data,
                reload: () {
                  setState(() {});
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: const Text(
                    "Rewards",
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),
              RewardItem(
                title: "50% Rabatt auf die nächste Ladung",
                id: "0a3f",
                imgUrl: "assets/kelag_ladestation.jpg",
                kelaxCost: 1000,
                reduceKelaxBalance: _reduceBalance,
                tag: "heroTag_1",
              ),
              RewardItem(
                title: "20€ Nachlass auf Stromrechnung",
                id: "0a40",
                imgUrl: "assets/strom.jfif",
                kelaxCost: 2000,
                reduceKelaxBalance: _reduceBalance,
                tag: "heroTag_2",
              ),
              RewardItem(
                title: "Gratis Emmi Caffè Latte beim Spar/Hofer",
                id: "0a41",
                imgUrl: "assets/kaffee.jpg",
                kelaxCost: 100,
                reduceKelaxBalance: _reduceBalance,
                tag: "heroTag_3",
              ),
            ],
          ));
        },
      ),
    );
  }
}
