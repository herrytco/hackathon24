import 'dart:math';

import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/component/gamble/number_wheel.dart';
import 'package:hackathon24/component/header.dart';
import 'package:hackathon24/constants/labels.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/model/app_state.dart';
import 'package:hackathon24/model/gamble_result.dart';
import 'package:hackathon24/services/balance_service.dart';

class GamblePage extends StatefulWidget {
  const GamblePage({super.key});

  @override
  State<GamblePage> createState() => _GamblePageState();
}

class _GamblePageState extends State<GamblePage> {
  int _stake = 100;
  var result = GambleResult.random();

  void _adjustStake(int change, int balance) {
    setState(() {
      int stakesAfter = max(_stake + change, 0);
      while (stakesAfter > balance) {
        stakesAfter -= change.abs();
      }

      _stake = stakesAfter;
    });
  }

  void _onSpin(ScaffoldMessengerState scaffoldState) async {
    setState(() {
      result.wipe();
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      result.roll();
    });

    if (result.isWin) {
      await GetIt.I.get<BalanceService>().addBalance(_stake);
      scaffoldState.showSnackBar(
        SnackBar(content: Text("Du hast $_stake $coinNameShort gewonnen!")),
      );
    } else {
      await GetIt.I.get<BalanceService>().removeBalance(_stake);
      scaffoldState.showSnackBar(
        const SnackBar(
          content: Text("Leider kein Gewinn!"),
          duration: Duration(milliseconds: 700),
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double wheelWidth = MediaQuery.of(context).size.width / 6;

    return Scaffold(
      appBar: KelagAppHeader.header,
      body: FutureBuilder(
        future: loadAppState(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          if (data == null) return const SizedBox();

          return Column(
            children: [
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Punktestand: ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: kelagGreen),
                  ),
                  AnimatedDigitWidget(
                    value: data.balance,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: kelagGreen),
                  ),
                  Text(
                    " $coinNameShort",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: kelagGreen),
                  ),
                ],
              ),
              // adjust stake
              Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => _adjustStake(-10, data.balance),
                          child: const Text("-10"),
                        ),
                        ElevatedButton(
                          onPressed: () => _adjustStake(-50, data.balance),
                          child: const Text("-50"),
                        ),
                        ElevatedButton(
                          onPressed: () => _adjustStake(-100, data.balance),
                          child: const Text("-100"),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "$_stake $coinNameShort",
                            style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text("Einsatz"),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => _adjustStake(10, data.balance),
                          child: const Text("+10"),
                        ),
                        ElevatedButton(
                          onPressed: () => _adjustStake(50, data.balance),
                          child: const Text("+50"),
                        ),
                        ElevatedButton(
                          onPressed: () => _adjustStake(100, data.balance),
                          child: const Text("+100"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(16),
                child: Divider(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberWheel(
                    width: wheelWidth,
                    value: result.x,
                  ),
                  NumberWheel(
                    width: wheelWidth,
                    value: result.y,
                  ),
                  NumberWheel(
                    width: wheelWidth,
                    value: result.z,
                  ),
                ],
              ),

              const Gap(16),

              ElevatedButton.icon(
                onPressed: _stake <= data.balance
                    ? () => _onSpin(ScaffoldMessenger.of(context))
                    : null,
                label: const Text("Spin to Win"),
              ),
            ],
          );
        },
      ),
    );
  }
}
