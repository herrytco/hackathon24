import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon24/model/app_state.dart';
import 'package:hackathon24/model/chargepoint.dart';
import 'package:hackathon24/services/icon_helper.dart';

class ChargePointMap extends StatelessWidget {
  const ChargePointMap({
    super.key,
    required this.state,
    required this.controller,
    required this.onSelect,
  });

  final AppState state;
  final Completer<GoogleMapController> controller;
  final void Function(ChargePoint chargePoint) onSelect;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: const CameraPosition(
        zoom: 15,
        target: LatLng(
          46.6106852,
          13.8097518,
        ),
      ),
      markers: {
        const Marker(
          markerId: MarkerId("myPosition"),
          position: LatLng(
            46.6106852,
            13.8097518,
          ),
        ),
        for (var chargePoint in state.chargePoints)
          Marker(
            markerId: MarkerId("chargePoint_${chargePoint.id}"),
            position: chargePoint.position,
            icon: GetIt.I.get<IconHelper>().chargePointMarker!,
            onTap: () => onSelect(chargePoint),
          ),
      },
      onMapCreated: (GoogleMapController c) {
        controller.complete(c);
      },
      minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
    );
  }
}
