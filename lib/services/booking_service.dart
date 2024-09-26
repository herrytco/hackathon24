import 'package:hackathon24/model/booking.dart';
import 'package:hackathon24/model/chargepoint.dart';

class BookingService {
  List<Booking> bookings = [
    Booking(
      DateTime.fromMillisecondsSinceEpoch(1727281819),
      2,
      end: DateTime.fromMillisecondsSinceEpoch(1727327403),
    ),
    Booking(
      DateTime.fromMillisecondsSinceEpoch(1727246539),
      1,
      end: DateTime.fromMillisecondsSinceEpoch(1727249419),
    ),
  ];

  Future<void> startLoading(
    ChargePoint chargePoint,
    DateTime start,
    DateTime end,
  ) async {
    bookings.add(Booking(DateTime.now(), chargePoint.id));
  }
}
