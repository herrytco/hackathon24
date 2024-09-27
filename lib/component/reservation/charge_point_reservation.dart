import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/constants/car_constants.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/model/chargepoint.dart';
import 'package:hackathon24/services/booking_service.dart';
import 'package:intl/intl.dart';

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
  RangeValues _hourSelection = const RangeValues(5, 10);

  String _timeToLabel(double time, int startingHour) {
    var now = DateTime.now();
    var start = DateTime(now.year, now.month, now.day, startingHour);
    var timestamp = DateTime.fromMillisecondsSinceEpoch(
        (start.millisecondsSinceEpoch + time * (60 * 60 * 1000)).toInt());

    NumberFormat formatter = NumberFormat("00");

    return "${formatter.format(timestamp.hour)}:${formatter.format(timestamp.minute)}";
  }

  double get startSelection => (_hourSelection.start * 2).round() / 2;
  double get endSelection => (_hourSelection.end * 2).round() / 2;

  RangeLabels get rangeLabels => RangeLabels(
        _timeToLabel(startSelection, 18),
        _timeToLabel(endSelection, 18),
      );

  double get selectedDurationInHours => endSelection - startSelection;

  double get expectedPower => min(batteryCapactiy * batteryPercentage,
      selectedDurationInHours * widget.chargePoint.maxKw);

  void _onBooking(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime start = DateTime(now.year, now.month, now.day, 18); // today 18:00
    start = DateTime.fromMillisecondsSinceEpoch(
        (start.millisecondsSinceEpoch + (startSelection * 60 * 60 * 1000))
            .toInt());

    DateTime end = DateTime.fromMillisecondsSinceEpoch(
      (start.millisecondsSinceEpoch +
              (selectedDurationInHours * (60 * 60 * 1000)))
          .toInt(),
    );
    await GetIt.I.get<BookingService>().startLoading(
          widget.chargePoint,
          start,
          end,
          selectedDurationInHours,
          expectedPower,
          expectedPower * tariff,
        );

    Navigator.of(context).pop();
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.chargePoint.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
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
                  max: 14,
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
                onPressed: () => _onBooking(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Buchen"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
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
