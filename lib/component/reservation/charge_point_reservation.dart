import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_multi_slider/flutter_multi_slider.dart';
import 'package:gap/gap.dart';
import 'package:hackathon24/constants/car_constants.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/model/chargepoint.dart';

class ChargePointView extends StatefulWidget {
  const ChargePointView({
    super.key,
    required this.chargePoint,
  });

  final ChargePoint chargePoint;

  @override
  State<ChargePointView> createState() => _ChargePointViewState();
}

class _ChargePointViewState extends State<ChargePointView> {
  RangeValues _hourSelection = const RangeValues(5, 20);

  String _timeToLabel(double time, int startingHour) {
    var roundedTime = (time * 2).round() / 2;

    int hour = (startingHour + roundedTime * 0.5).toInt();
    if (hour >= 24) hour -= 24;
    if (roundedTime % 2 == 1) return "$hour:30";
    return "$hour:00";
  }

  RangeLabels get rangeLabels => RangeLabels(
        _timeToLabel(_hourSelection.start, 18),
        _timeToLabel(_hourSelection.end, 18),
      );

  double get selectedDurationInHours =>
      (((_hourSelection.end - _hourSelection.start) / 2) * 2).round() / 2;

  double get expectedPower => min(batteryCapactiy * batteryPercentage,
      selectedDurationInHours * widget.chargePoint.maxKw);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kelagGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Chip(label: Text("${widget.chargePoint.maxKw} KW")),
                const Chip(label: Text("2 Anschlüsse")),
              ],
            ),
          ),
          const Divider(),
          Row(
            children: [
              const Gap(16),
              const Text(
                "18:00",
                style: TextStyle(color: Colors.white),
              ),
              Expanded(
                child: RangeSlider(
                  values: _hourSelection,
                  min: 0,
                  max: 28,
                  onChanged: (value) {
                    setState(() {
                      _hourSelection = value;
                    });
                  },
                  labels: rangeLabels,
                ),
              ),
              const Text(
                "8:00",
                style: TextStyle(color: Colors.white),
              ),
              const Gap(16),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gebuchter Zeitraum: ${rangeLabels.start} - ${rangeLabels.end} ($selectedDurationInHours Stunden)",
                  style: const TextStyle(color: Colors.white),
                ),
                const Text(
                  "Tarif: 0.30c / KWh",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "erw. Ladeleistung: ${expectedPower.toStringAsFixed(2)} KWh",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "erw. Kosten: ${(expectedPower * tariff).toStringAsFixed(2)}€",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Buchen"),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Abbrechen"),
              ),
            ],
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
