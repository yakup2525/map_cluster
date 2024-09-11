// app_navigator.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_cluster/features/home/home.dart';

import '/core/core.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({
    super.key,
  });

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: NavigationService.instance.navigatorKey,
      initialRoute: AppRoutes.initialRoute.routeName,
      onGenerateRoute: (RouteSettings settings) {
        final AppRoutes route = _getRouteFromName(settings.name);
        switch (route) {
          case AppRoutes.initialRoute:
            return animateToPage(BlocProvider(
              create: (BuildContext context) => HomeCubit(),
              child: const HomeScreen(),
            ));

          default:
            return animateToPage(const HomeScreen());
        }
      },
    );
  }

  AppRoutes _getRouteFromName(String? name) {
    return AppRoutes.values.firstWhere((e) => e.routeName == name);
  }
}
