import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MarkerStrategy {
  Marker buildMarker(double latitude, double longitude, String id,
      {dynamic data});
}
