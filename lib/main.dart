import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PRoutes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jora Customer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      initialRoute: PPages.splash,
      onGenerateRoute: Routes.genericRoute,
    );
  }
}