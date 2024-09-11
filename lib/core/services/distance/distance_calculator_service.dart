/// * Strategy Tasarım kalıbı ile oluşturulmuş distance hesaplama servisinin interface'i
abstract interface class IDistanceCalculatorService {
  double calculateDistance(double lat1, double lon1, double lat2, double lon2);
}
