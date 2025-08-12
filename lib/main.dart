import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/data/repositories/characters_repository.dart';
import 'package:rick_and_morty_app/data/services/app_service.dart';
import 'package:rick_and_morty_app/ui/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF69C8EC), brightness: Brightness.dark),
      useMaterial3: true,
    );

    return MultiProvider(
      providers: [
        Provider(create: (context) => AppService.createApiClient()),
        Provider(create: (context) => CharactersRepository(context.read())),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Rick and Morty',
            theme: theme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
