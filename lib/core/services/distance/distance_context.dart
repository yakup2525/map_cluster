import '/core/core.dart';

/// * Distance servise hangi algoritma ile erişeceğimizi yönetip işlemi yaptığımız sınıf
class DistanceServiceContext {
  IDistanceCalculatorService? _strategy;

  void setStrategy(IDistanceCalculatorService strategy) {
    _strategy = strategy;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return _strategy!.calculateDistance(lat1, lon1, lat2, lon2);
  }
}
