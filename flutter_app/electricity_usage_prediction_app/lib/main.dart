import 'package:electricity_usage_prediction_app/pages/homepage.dart';
import 'package:flutter/material.dart';

///import 'package:wzpdcl_app_new/core/pages/spalash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electricity Usage Prediction',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 39, 47, 141),
        ),
        useMaterial3: true,
      ),
      home: Homepage(),
    );
  }
}
