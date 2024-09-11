// app_routes.dart
enum AppRoutes {
  initialRoute,
}

extension AppRoutesExtension on AppRoutes {
  String get routeName {
    switch (this) {
      case AppRoutes.initialRoute:
        return '/';
    }
  }
}
