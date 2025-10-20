// lib/main.dart
import 'package:flutter/material.dart';
import 'package:nutridoctor/pages/camera/camera_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutri Doctor IA',
      theme: ThemeData(
        primarySwatch: Colors.green, // Um tema mais "nutri"
      ),
      home: const CameraScreen(), // Mude aqui!
    );
  }
}
