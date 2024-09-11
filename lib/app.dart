import 'package:flutter/material.dart';
import 'package:map_cluster/core/navigation/app_navigator.dart';

class MapClusterApp extends StatefulWidget {
  const MapClusterApp({super.key});

  @override
  State<MapClusterApp> createState() => _MapClusterAppState();
}

class _MapClusterAppState extends State<MapClusterApp> {
  @override
  Widget build(BuildContext context) {
    return const AppNavigator();
  }
}
