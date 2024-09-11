import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/core/core.dart';

class MarkerContext {
  MarkerStrategy? _strategy;

  // Strateji atama
  void setStrategy(MarkerStrategy strategy) {
    _strategy = strategy;
  }

  // Marker oluşturma
  Marker createMarker(double latitude, double longitude, String id,
      {dynamic data}) {
    return _strategy!.buildMarker(latitude, longitude, id, data: data);
  }
}
