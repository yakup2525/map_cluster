import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/core/core.dart';

final class HomeCubit extends BaseCubit<AppState> {
  HomeCubit() : super(const InitialState());

  Position? currentLocation;
  final distanceContext = DistanceServiceContext();
  MarkerContext markerContext = MarkerContext();
  Set<Marker> markers = {};
  double currentZoom = 10.0;
  final double defaultLatitude = 39.9334; // Varsayılan konum (Ankara)
  final double defaultLongitude = 32.8597;

  Future<void> fetchLocation() async {
    safeEmit(const LoadingState());
    try {
      ILocationService locationService =
          LocationService(); // Interface üzerinden erişim
      currentLocation = await locationService.getCurrentLocation();
      LogManager.debug(
          'Lat: ${currentLocation?.latitude}, Long: ${currentLocation?.longitude}');

      // await Future.delayed(const Duration(milliseconds: 3000));

      safeEmit(const SuccessState());
    } catch (e) {
      if (e is AppErrorModel) {
        LogManager.debug('Hata: ${e.message}, Detay: ${e.details}');
      } else {
        LogManager.debug('${StringConstanst.appTitle}: $e');
      }
      safeEmit(ErrorState(e));
    }
  }

// Zoom seviyesine göre markerları yönetme
  void loadMarkers() {
    markers.clear(); // Eski markerları temizle

    if (currentZoom < 8) {
      // Zoom düşükse cluster yap
      createClusterMarkers();
    } else {
      // Zoom yüksekse tek tek marker göster
      createIndividualMarkers();
    }

    scrSet();
  }

// Cluster marker'larını oluşturma
  void createClusterMarkers() {
    Set<Marker> clusterMarkers = {};

    for (int i = 0; i < dummyUsers.length; i++) {
      LatLng position = LatLng(dummyUsers[i].latitude, dummyUsers[i].longitude);
      bool isClustered = false;

      // Diğer marker'lara mesafe kontrolü yap
      for (int j = i + 1; j < dummyUsers.length; j++) {
        double distance = distanceContext.calculateDistance(
            position.latitude,
            position.longitude,
            dummyUsers[j].latitude,
            dummyUsers[j].longitude);

        // Eğer iki marker birbirine yakınsa, cluster oluştur 400 km mesafe, dummy datalarda test için uygun
        if (distance < 250) {
          markerContext.setStrategy(ClusterMarkerStrategy());
          clusterMarkers.add(
            markerContext.createMarker(
              (position.latitude + dummyUsers[j].latitude) / 2,
              (position.longitude + dummyUsers[j].longitude) / 2,
              'cluster_$i',
              data: {'count': 2},
            ),
          );
          isClustered = true;
          break;
        }
      }

      // Eğer cluster yapılmadıysa, marker'ı normal göster
      if (!isClustered) {
        markerContext.setStrategy(BasicMarkerStrategy());
        clusterMarkers.add(
          markerContext.createMarker(
            position.latitude,
            position.longitude,
            'marker_$i',
            data: dummyUsers[i],
          ),
        );
      }
    }

    markers = clusterMarkers;

    scrSet();
  }

  // Bireysel marker'ları oluşturma
  void createIndividualMarkers() {
    for (int i = 0; i < dummyUsers.length; i++) {
      markerContext.setStrategy(CustomMarkerStrategy());
      markers.add(
        markerContext.createMarker(
          dummyUsers[i].latitude,
          dummyUsers[i].longitude,
          'user_marker_${dummyUsers[i].name}',
          data: {
            'name': dummyUsers[i].name,
            'distance': distanceContext.calculateDistance(
              currentLocation?.latitude ?? defaultLatitude,
              currentLocation?.longitude ?? defaultLongitude,
              dummyUsers[i].latitude,
              dummyUsers[i].longitude,
            )
          },
        ),
      );
    }
  }

  void scrSet() {
    safeEmit(const InitialState());

    safeEmit(const SuccessState());
  }
}
