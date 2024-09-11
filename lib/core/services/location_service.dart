import 'package:geolocator/geolocator.dart';

import '/core/core.dart';

abstract interface class ILocationService {
  Future<Position> getCurrentLocation();
}

// Interface'i import et

class LocationService implements ILocationService {
  // Singleton tasarımı ile sadece bir örnek yaratılır
  static final LocationService _instance = LocationService._internal();
  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  /// Konum izni ve hizmetini kontrol etme ve kullanıcının iznine göre ayarlama
  Future<void> _checkPermissionsAndService() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum hizmeti etkin mi?
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw AppErrorModel('Konum servisleri etkin değil',
          details: 'Servis etkinleştirilemedi.');
    }

    // Konum izni kontrol et
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw AppErrorModel('Konum izni reddedildi',
            details: 'Kullanıcı izni vermedi.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw AppErrorModel('Konum izni kalıcı olarak reddedildi',
          details: 'İzinleri değiştirmek için ayarları kontrol edin.');
    }
  }

  /// Mevcut konumu alma
  @override
  Future<Position> getCurrentLocation() async {
    try {
      await _checkPermissionsAndService();
      return await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best),
      );
    } catch (e) {
      throw AppErrorModel('Konum alınırken hata oluştu', details: e.toString());
    }
  }
}
