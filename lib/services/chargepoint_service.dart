import 'package:hackathon24/constants/labels.dart';
import 'package:hackathon24/model/chargepoint.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ChargePointService {
  List<ChargePoint>? _points;

  Future<List<ChargePoint>> loadChargePoints() async {
    if (_points == null) {
      List<dynamic> json =
          jsonDecode(await rootBundle.loadString(filepathChargePoints));

      _points = [];

      for (Map<String, dynamic> row in json) {
        _points!.add(ChargePoint.fromJson(row));
      }
    }

    return _points!;
  }
}
