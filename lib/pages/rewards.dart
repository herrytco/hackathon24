import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/services/balance_service.dart';
import 'package:hackathon24/component/welcome/balance_card.dart';

class _RewardData {
  int balance;

  _RewardData(this.balance);
}

Future<_RewardData> _loadData() async {
  int balance = GetIt.I.get<BalanceService>().balance;

  return _RewardData(balance);
}

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

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
            ],
          );
        },
      ),
    );
  }
}
