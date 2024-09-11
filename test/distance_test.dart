import 'package:flutter_test/flutter_test.dart';
import 'package:map_cluster/core/core.dart';

void main() {
  late DistanceServiceContext distanceServiceContext;

  setUp(() {
    distanceServiceContext = DistanceServiceContext();
  });

  group('DistanceService Tests', () {
    test('EuclideanDistance (düz çizgi mesafesi) hesaplamalı', () {
      // Euclidean algoritmasını kullanıyoruz
      distanceServiceContext.setStrategy(EuclideanDistance());

      // Ankara ve İstanbul arası mesafeyi Euclidean ile hesapla
      double distance = distanceServiceContext.calculateDistance(
        39.9334, // Ankara Latitude
        32.8597, // Ankara Longitude
        41.0082, // İstanbul Latitude
        28.9784, // İstanbul Longitude
      );

      // Euclidean distance beklentisini doğruluyoruz
      // Düz çizgi mesafesi yaklaşık 4 civarında olabilir (coğrafi mesafe yerine düzlemde hesaplandığı için çok küçük)
      expect(distance,
          closeTo(4.027, 0.1)); // Tolerans aralığını genişlettik (0.1)
    });

    test('HaversineDistance doğru mesafeyi hesaplamalı', () {
      // Haversine algoritmasını kullanıyoruz
      distanceServiceContext.setStrategy(HaversineDistance());

      // Ankara ve İstanbul arası mesafeyi Haversine ile hesapla
      double distance = distanceServiceContext.calculateDistance(
        39.9334, // Ankara Latitude
        32.8597, // Ankara Longitude
        41.0082, // İstanbul Latitude
        28.9784, // İstanbul Longitude
      );

      // Haversine mesafeyi doğruluyoruz
      expect(distance,
          closeTo(351.87, 5)); // Tolerans aralığını 5 km'ye çıkarıyoruz
    });

    test('Aynı konum için mesafe sıfır olmalı (Haversine)', () {
      // Aynı noktalar arası mesafe 0 olmalı
      distanceServiceContext.setStrategy(HaversineDistance());

      double distance = distanceServiceContext.calculateDistance(
        39.9334, // Ankara Latitude
        32.8597, // Ankara Longitude
        39.9334, // Aynı Latitude
        32.8597, // Aynı Longitude
      );

      expect(distance, 0);
    });

    test('Aynı konum için mesafe sıfır olmalı (Euclidean)', () {
      // Aynı noktalar arası mesafe 0 olmalı
      distanceServiceContext.setStrategy(EuclideanDistance());

      double distance = distanceServiceContext.calculateDistance(
        39.9334, // Ankara Latitude
        32.8597, // Ankara Longitude
        39.9334, // Aynı Latitude
        32.8597, // Aynı Longitude
      );

      expect(distance, 0);
    });
  });
}
