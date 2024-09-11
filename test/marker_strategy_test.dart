import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_cluster/core/core.dart'; // MarkerContext, CustomMarkerStrategy, BasicMarkerStrategy, ClusterMarkerStrategy sınıfları burada tanımlı

void main() {
  late MarkerContext markerContext;

  setUp(() {
    markerContext = MarkerContext();
  });

  group('MarkerStrategy Tests', () {
    test('CustomMarkerStrategy ile marker doğru oluşturulmalı', () {
      // Custom stratejiyi kullan
      markerContext.setStrategy(CustomMarkerStrategy());

      // Marker oluştur
      Marker marker = markerContext.createMarker(
        39.9334, // Latitude
        32.8597, // Longitude
        'custom_marker',
        data: {'name': 'Hasan Yoldaş', 'distance': 5.2},
      );

      // Marker'in doğru özelliklere sahip olduğunu test ediyoruz
      expect(marker.markerId.value, 'custom_marker');
      expect(marker.position.latitude, 39.9334);
      expect(marker.position.longitude, 32.8597);
      expect(marker.infoWindow.title, 'Hasan Yoldaş');
      expect(marker.infoWindow.snippet, '5.2 km uzaklıkta'); // Mesafe bilgisi
      // expect(marker.icon,
      //     BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
    });

    test('ClusterMarkerStrategy ile marker doğru oluşturulmalı', () {
      // Cluster stratejisini kullan
      markerContext.setStrategy(ClusterMarkerStrategy());

      // Marker oluştur
      Marker marker = markerContext.createMarker(
        39.9334, // Latitude
        32.8597, // Longitude
        'cluster_marker',
        data: {'count': 10},
      );

      // Marker'in doğru özelliklere sahip olduğunu test ediyoruz
      expect(marker.markerId.value, 'cluster_marker');
      expect(marker.position.latitude, 39.9334);
      expect(marker.position.longitude, 32.8597);
      expect(marker.infoWindow.title, '10 users'); // Kullanıcı sayısı
      // expect(
      //     marker.icon,
      //     BitmapDescriptor.defaultMarkerWithHue(
      //         BitmapDescriptor.hueViolet)); // Özel renk
    });

    test('BasicMarkerStrategy ile marker doğru oluşturulmalı', () {
      // Basic stratejiyi kullan
      markerContext.setStrategy(BasicMarkerStrategy());

      // Marker oluştur
      Marker marker = markerContext.createMarker(
        39.9334, // Latitude
        32.8597, // Longitude
        'basic_marker',
      );

      // Marker'in doğru özelliklere sahip olduğunu test ediyoruz
      expect(marker.markerId.value, 'basic_marker');
      expect(marker.position.latitude, 39.9334);
      expect(marker.position.longitude, 32.8597);
      expect(marker.infoWindow.title, 'Simple Marker');
      expect(marker.icon, BitmapDescriptor.defaultMarker);
    });
  });
}
