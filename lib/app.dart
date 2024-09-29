import 'package:flutter/material.dart';
import 'package:quiz_app/admin/admin_log_in.dart';
import 'package:quiz_app/ui/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz-App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: _textTheme,
      ),
      home: const AdminLogIn(),
    );
  }
}


const TextTheme _textTheme = TextTheme(
  displayLarge: TextStyle(
    color: Colors.black,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  ),
  displayMedium: TextStyle(
    color: Colors.black,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  ),
  displaySmall: TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
  headlineLarge: TextStyle(
    color: Colors.black,
    fontSize: 22,
    fontWeight: FontWeight.w600,
  ),
  headlineMedium: TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  ),
  headlineSmall: TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  ),
  titleLarge: TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  titleMedium: TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  titleSmall: TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),
  bodyLarge: TextStyle(
    color: Colors.black,
    fontSize: 16,
  ),
  bodyMedium: TextStyle(
    color: Colors.black,
    fontSize: 14,
  ),
  bodySmall: TextStyle(
    color: Colors.black,
    fontSize: 12,
  ),
  labelLarge: TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  labelMedium: TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
  labelSmall: TextStyle(
    color: Colors.black,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  ),
);