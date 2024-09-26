import 'package:google_maps_flutter/google_maps_flutter.dart';

enum ChargeType { ac, dc }

class ChargePoint {
  final int id;
  final int maxKw;
  final bool bonus;
  final String name;
  final LatLng position;
  final ChargeType type;

  ChargePoint(
    this.id,
    this.maxKw,
    this.bonus,
    this.name,
    this.position,
    this.type,
  );

  factory ChargePoint.fromJson(Map<String, dynamic> row) {
    String coordString = row["cord"];

    double lat = double.parse(coordString.split(",")[0].trim());
    double long = double.parse(coordString.split(",")[1].trim());

    var type = ChargeType.ac;
    if (row["type"] == "DC") {
      type = ChargeType.dc;
    }

    return ChargePoint(
      row["id"],
      row["kW"],
      row["Bonus"],
      row["name"],
      LatLng(lat, long),
      type,
    );
  }
}
