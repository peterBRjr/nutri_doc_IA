// lib/main.dart
import 'package:flutter/material.dart';
import 'package:nutridoctor/pages/camera/camera_screen.dart';
import 'package:nutridoctor/pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nutri Doctor IA',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CameraScreen(),
    );
  }
}
