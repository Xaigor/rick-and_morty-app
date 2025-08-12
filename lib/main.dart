// Ajuste: Injeção via provider de ApiClient e CharactersRepository para uso com context.read().
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/data/repositories/characters_repository.dart';
import 'package:rick_and_morty_app/data/services/api_client.dart';
import 'package:rick_and_morty_app/data/services/app_service.dart';
import 'package:rick_and_morty_app/ui/characters/widgets/characters_screen.dart';

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
        Provider<ApiClient>(
          // Troque apenas AppService.defaultClient para alternar entre dio/http
          create: (_) => AppService.createApiClient(),
        ),
        ProxyProvider<ApiClient, CharactersRepository>(
          update: (_, apiClient, __) => CharactersRepository(apiClient),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Rick and Morty',
            theme: theme,
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CharactersScreen(),
              ),
            );
          },
          child: Text("navegar"),
        ),
      ),
    );
  }
}
