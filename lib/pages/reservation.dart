import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hackathon24/component/header.dart';
import 'package:hackathon24/component/hello.dart';
import 'package:hackathon24/constants/labels.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/model/app_state.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KelagAppHeader.header,
      body: FutureBuilder(
        future: loadAppState(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: HelloWidget(),
                    ),
                    Text(
                      "${data?.balance} $coinNameShort",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: kelagGreen,
                          ),
                    ),
                  ],
                ),
                Gap(16),
                Text(
                  "Buch deine Ladesäule noch heute!",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kelagGreen,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
