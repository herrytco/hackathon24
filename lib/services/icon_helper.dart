import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IconHelper {
  BitmapDescriptor? chargePointMarker;

  Future<void> init() async {
    chargePointMarker = await _initializeGreenMarker();
  }

  Future<BitmapDescriptor> _initializeGreenMarker() async {
    return await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(20, 27)),
      "assets/green-marker.png",
    );
  }
}
