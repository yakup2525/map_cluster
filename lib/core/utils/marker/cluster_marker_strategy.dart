import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/core/core.dart';

class ClusterMarkerStrategy implements MarkerStrategy {
  @override
  Marker buildMarker(double latitude, double longitude, String id,
      {dynamic data}) {
    return Marker(
      markerId: MarkerId(id),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(
        title: "${data['count']} users", // Cluster'daki kullanıcı sayısı
        snippet: StringConstanst.clusterDescription,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet), // Cluster için özel renk
    );
  }
}
