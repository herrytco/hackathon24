import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon24/component/header.dart';
import 'package:hackathon24/model/app_state.dart';
import 'package:hackathon24/services/booking_service.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KelagAppHeader.header,
      body: FutureBuilder<AppState>(
        future: loadAppState(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          return Column(
            children: GetIt.I
                .get<BookingService>()
                .bookings
                .map(
                  (e) => Text(e.chargePointId.toString()),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
