import 'package:animated_digit/animated_digit.dart';
import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hackathon24/constants/labels.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/model/app_state.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.balance,
  });

  final AppState? balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        color: kelagGreen,
        elevation: 20.0,
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 160,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: FloatingBubbles.alwaysRepeating(
                  noOfBubbles: 10,
                  colorsOfBubbles: [
                    Colors.white.withOpacity(.5),
                    Colors.white.withOpacity(.3),
                    Colors.white.withOpacity(.2),
                    Colors.white.withOpacity(.1),
                  ],
                  sizeFactor: .1,
                ),
              ),
              Builder(builder: (context) {
                return Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "$coinName Konto",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.white),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AnimatedDigitWidget(
                            value: balance?.balance ?? 0,
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: Colors.white),
                          ),
                          const Gap(4),
                          Text(
                            coinNameShort,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                          children: [
                            const TextSpan(
                              text: "gespart durch NightLoading: ",
                            ),
                            TextSpan(
                              text:
                                  "${balance?.euro.toStringAsFixed(2)} € / ${balance?.co2.toStringAsFixed(2)}g CO₂",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
