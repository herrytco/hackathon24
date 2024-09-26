import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hackathon24/constants/theme_data.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.balance,
  });

  final int? balance;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kelagGreen,
      elevation: 10.0,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "eCoins",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            ),
            Text(
              "$balance e's",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Colors.white),
            ),
            const Gap(16),
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
                    text: "$balance eCoins / 10.2g CO₂",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
