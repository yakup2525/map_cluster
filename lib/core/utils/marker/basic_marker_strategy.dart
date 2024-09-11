import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/core/core.dart';

class BasicMarkerStrategy implements MarkerStrategy {
  @override
  Marker buildMarker(double latitude, double longitude, String id,
      {dynamic data}) {
    return Marker(
      markerId: MarkerId(id),
      position: LatLng(latitude, longitude),
      infoWindow: const InfoWindow(
        title: StringConstanst.simplemarker,
        snippet: StringConstanst.simpleMarkerDescription,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
  }
}
