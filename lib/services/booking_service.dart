import 'package:hackathon24/model/booking.dart';
import 'package:hackathon24/model/chargepoint.dart';

class BookingService {
  List<Booking> bookings = [
    Booking(
      DateTime.fromMillisecondsSinceEpoch(1727281819000),
      2,
      DateTime.fromMillisecondsSinceEpoch(1727327403000),
      30.2,
      16.95,
      false,
    ),
    Booking(
      DateTime.fromMillisecondsSinceEpoch(1727246539000),
      1,
      DateTime.fromMillisecondsSinceEpoch(1727249419000),
      10.2,
      6.95,
      false,
    ),
  ];

  Future<void> startLoading(
    ChargePoint chargePoint,
    DateTime start,
    DateTime end,
    double chargedHours,
    double chargedKWh,
    double price,
  ) async {
    bookings.add(Booking(
      start,
      chargePoint.id,
      end,
      chargedKWh,
      price,
      true,
    ));
  }
}
