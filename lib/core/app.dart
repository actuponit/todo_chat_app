import 'package:flutter/material.dart';

import 'home_page.dart';
import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter interface',
      onGenerateRoute: generateRoute,
      home: const HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        primaryColor: const Color.fromRGBO(43, 81, 243, 1),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          labelMedium: TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 111, 111, 111), height: 1.5),
          labelSmall: TextStyle(fontSize: 15.0, color: Color.fromARGB(255, 136, 136, 136), height: 1.5),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}