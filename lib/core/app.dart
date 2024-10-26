import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/presentation/blocs/bloc/auth_bloc.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../injection_container.dart';
import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => locator<AuthBloc>()..add(AuthStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'Todo and Chat app',
        onGenerateRoute: generateRoute,
        home: const LogInScreen(),
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(43, 81, 243, 1),
            error: Colors.redAccent,
            primary: const Color.fromRGBO(43, 81, 243, 1),
            secondary: Colors.lightBlueAccent,
            surface: Colors.blueGrey[50],
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(43, 81, 243, 1),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          primaryColor: const Color.fromRGBO(43, 81, 243, 1),
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            labelMedium: TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 111, 111, 111),
                height: 1.5),
            labelSmall: TextStyle(
                fontSize: 15.0,
                color: Color.fromARGB(255, 136, 136, 136),
                height: 1.5),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
