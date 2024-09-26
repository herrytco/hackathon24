class Booking {
  final DateTime start;
  DateTime? end;
  final int chargePointId;
  final double chargedKWh;
  final double price;
  bool isOpen;

  Booking(
    this.start,
    this.chargePointId,
    this.end,
    this.chargedKWh,
    this.price,
    this.isOpen,
  );
}
