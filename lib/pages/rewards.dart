import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/services/activated_service.dart';
import 'package:hackathon24/services/balance_service.dart';
import 'package:hackathon24/component/welcome/balance_card.dart';
import 'package:hackathon24/component/rewards/reward_item.dart';

class _RewardData {
  int balance;

  _RewardData(this.balance);
}

Future<_RewardData> _loadData() async {
  int balance = GetIt.I.get<BalanceService>().balance;

  return _RewardData(balance);
}

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
      body: FutureBuilder<_RewardData>(
        future: _loadData(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          return Column(
            children: [
              BalanceCard(balance: data?.balance),
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
              )
            ],
          );
        },
      ),
    );
  }
}
