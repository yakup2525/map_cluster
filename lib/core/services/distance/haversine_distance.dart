import 'dart:math';

import '/core/core.dart';

/// * Distance servis için Haversine algoritması ile hesaplama
class HaversineDistance implements IDistanceCalculatorService {
  @override
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // Dünya'nın yarıçapı (km)
    double dLat = _degreeToRadian(lat2 - lat1);
    double dLon = _degreeToRadian(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreeToRadian(lat1)) *
            cos(_degreeToRadian(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Kilometre cinsinden mesafe
  }

  double _degreeToRadian(double degree) {
    return degree * pi / 180;
  }
}
