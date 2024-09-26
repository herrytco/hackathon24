import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/component/header.dart';
import 'package:hackathon24/constants/theme_data.dart';
import 'package:hackathon24/model/app_state.dart';
import 'package:hackathon24/services/booking_service.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  String toPrettyDate(DateTime time) {
    DateFormat format = DateFormat("dd.MM.yyyy HH:mm");
    return format.format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KelagAppHeader.header,
      body: FutureBuilder<AppState>(
        future: loadAppState(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          if (data == null) return const SizedBox();

          return Column(
            children: GetIt.I
                .get<BookingService>()
                .bookings
                .map(
                  (e) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: e.isOpen ? Colors.red : kelagGreen,
                        width: 2.0,
                      ),
                    ),
                    color: kelagGreen,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.getChargePointForId(e.chargePointId).name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "${toPrettyDate(e.start)}  -  ${e.end != null ? toPrettyDate(e.end!) : 'jetzt'}",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${e.chargedKWh} KWh geladen"),
                              Text("${e.price} €"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
