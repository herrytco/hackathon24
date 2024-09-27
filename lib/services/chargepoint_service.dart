import 'package:hackathon24/model/chargepoint.dart';
import 'dart:convert';

const chargePointData = """
  [
    {
      "id": 1,
      "name": "Warmbader Straße 90",
      "type": "AC",
      "cord": "46.58810726068696, 13.827963687928575",
      "kW": 22,
      "Bonus": true
    },
    {
      "id": 2,
      "name": "Siemensstraße 2",
      "type": "AC",
      "cord": "46.5950316363853, 13.855660387731062",
      "kW": 11,
      "Bonus": false
    },
    {
      "id": 3,
      "name": "Maria-Gailer-Straße 38",
      "type": "DC",
      "cord": "46.60423810727758, 13.868333473329804",
      "kW": 300,
      "Bonus": false
    },
    {
      "id": 4,
      "name": "Gewerbezeile 2",
      "type": "AC",
      "cord": "46.60493245636251, 13.869607205247107",
      "kW": 11,
      "Bonus": false
    },
    {
      "id": 5,
      "name": "Freihausgasse/Khevenhüllergasse 1-7",
      "type": "AC",
      "cord": "46.61284262036459, 13.847402439496124",
      "kW": 22,
      "Bonus": false
    },
    {
      "id": 6,
      "name": "Nikolaigasse/Dreschnigstraße 43",
      "type": "AC",
      "cord": "46.61496229354874, 13.855034432279414",
      "kW": 22,
      "Bonus": false
    },
    {
      "id": 7,
      "name": "St. Magdalener Straße 81-83",
      "type": "AC",
      "cord": "46.6169149314481, 13.875954836043316",
      "kW": 22,
      "Bonus": false
    },
    {
      "id": 8,
      "name": "Bahnhofplatz",
      "type": "AC",
      "cord": "46.6179654160311, 13.847972431803367",
      "kW": 11,
      "Bonus": false
    }
  ]
""";

class ChargePointService {
  List<ChargePoint>? _points;

  Future<List<ChargePoint>> loadChargePoints() async {
    if (_points == null) {
      List<dynamic> json = jsonDecode(chargePointData);

      _points = [];

      for (Map<String, dynamic> row in json) {
        _points!.add(ChargePoint.fromJson(row));
      }
    }

    return _points!;
  }
}
