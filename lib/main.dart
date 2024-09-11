import 'package:flutter/material.dart';
import 'package:map_cluster/app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 47, 110, 198)),
        useMaterial3: true,
      ),
      home: const MapClusterApp(),
    );
  }
}
