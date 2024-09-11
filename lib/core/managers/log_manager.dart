import 'package:logger/logger.dart';

class LogManager {
  // FATAL log seviyesi logger paketi tarafından doğrudan desteklenmez.
  // Bu durum için error kullanılabilir.
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Gösterilecek metod çağrı sayısı
      errorMethodCount:
          8, // Stacktrace sağlandığında gösterilecek metod çağrı sayısı
      lineLength: 120, // Çıktının genişliği
      colors: true, // Renkli log mesajları
      printEmojis: true, // Her log mesajı için bir emoji yazdır
      // printTime: true, // Her log mesajında zaman damgası olup olmaması
    ),
  );

  static void trace(String message) {
    _logger.t(message);
  }

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    // FATAL log seviyesi logger paketi tarafından doğrudan desteklenmez.
    // Bu nedenle, bu özel durumu işlemek için 'error' kullanıyoruz
    _logger.e('FATAL: $message', error: error, stackTrace: stackTrace);
  }
}
