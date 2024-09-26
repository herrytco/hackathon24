class Booking {
  final DateTime start;
  DateTime? end;
  final int chargePointId;

  Booking(this.start, this.chargePointId, {this.end});
}
