// Ajuste: Splash screen com animação e tema Rick and Morty, navegando para CharactersScreen.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty_app/ui/characters/widgets/characters_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    _scale = Tween(begin: .9, end: 1.06)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CharactersScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B132B), Color(0xFF1C2541)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/pickle-rick.png', width: 300, height: 300),
                SizedBox(height: 12),
                SvgPicture.asset('assets/logo.svg', width: 400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
