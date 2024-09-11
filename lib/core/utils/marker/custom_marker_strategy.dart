import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/core/core.dart';

class CustomMarkerStrategy implements MarkerStrategy {
  @override
  Marker buildMarker(double latitude, double longitude, String id,
      {dynamic data}) {
    return Marker(
      markerId: MarkerId(id),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(
        title: data['name'], // Kullanıcı adı
        snippet:
            "${data['distance']} ${StringConstanst.kmDescription}", // Mesafe bilgisi
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue), // Özel marker rengi
    );
  }
}
