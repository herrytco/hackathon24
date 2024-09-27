import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hackathon24/component/gamble/number_wheel.dart';
import 'package:hackathon24/component/header.dart';
import 'package:hackathon24/constants/labels.dart';
import 'package:hackathon24/model/gamble_result.dart';

class GamblePage extends StatefulWidget {
  const GamblePage({super.key});

  @override
  State<GamblePage> createState() => _GamblePageState();
}

class _GamblePageState extends State<GamblePage> {
  int _stake = 100;
  var result = GambleResult.random();

  void _adjustStake(int change) {
    setState(() {
      _stake += change;
    });
  }

  void _onSpin() async {
    
  }

  @override
  Widget build(BuildContext context) {
    double wheelWidth = MediaQuery.of(context).size.width / 6;

    return Scaffold(
      appBar: KelagAppHeader.header,
      body: Column(
        children: [
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
                      onPressed: () => _adjustStake(-10),
                      child: const Text("-10"),
                    ),
                    ElevatedButton(
                      onPressed: () => _adjustStake(-50),
                      child: const Text("-50"),
                    ),
                    ElevatedButton(
                      onPressed: () => _adjustStake(-100),
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
                      onPressed: () => _adjustStake(10),
                      child: const Text("+10"),
                    ),
                    ElevatedButton(
                      onPressed: () => _adjustStake(50),
                      child: const Text("+50"),
                    ),
                    ElevatedButton(
                      onPressed: () => _adjustStake(100),
                      child: const Text("+100"),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(),

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
            onPressed: _onSpin,
            label: Text("Spin to Win"),
          ),
        ],
      ),
    );
  }
}
