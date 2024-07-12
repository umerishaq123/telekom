import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LatLng latLng = const LatLng(33.6844, 73.0479);
    String address = 'Islamabad';





    return GoogleMap(
      mapType: MapType.normal, // Set map type to normal for street view

      initialCameraPosition: CameraPosition(
        target: latLng,
        zoom: 20,
      ),
      markers: {
        Marker(
          infoWindow: InfoWindow(title: address),
          position: latLng,
          draggable: true,
          markerId: const MarkerId('1'),


        ),

      },

    );
  }


}
