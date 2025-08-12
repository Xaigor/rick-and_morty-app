// Ajuste: Métodos de animação e rota para detalhe (reuso em CharactersScreen).
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/models/character.dart';
import 'package:rick_and_morty_app/ui/characters/widgets/character_detail_screen.dart';

class CharacterDetailViewModel {
  // Ajuste: Controller padrão para animação de clique.
  static AnimationController createTapController(TickerProvider vsync) =>
      AnimationController(
          vsync: vsync, duration: const Duration(milliseconds: 110));

  // Ajuste: Animação de escala (press feedback).
  static Animation<double> createTapScale(AnimationController controller) =>
      Tween(begin: 1.0, end: 0.96)
          .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

  // Ajuste: Handlers de toque para reutilização.
  static void onTapDown(AnimationController c) => c.forward();
  static Future<void> onTapCancel(AnimationController c) => c.reverse();
  static Future<void> onTapUp(
      AnimationController c, VoidCallback navigate) async {
    await c.reverse();
    navigate();
  }

  // Ajuste: Rota com transição fade + slide para a tela de detalhes.
  static PageRouteBuilder buildDetailRoute(Character c, String heroTag) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (context, animation, secondaryAnimation) =>
          CharacterDetailScreen(character: c, heroTag: heroTag),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offset = Tween<Offset>(
                begin: const Offset(0, .06), end: Offset.zero)
            .animate(
                CurvedAnimation(curve: Curves.easeOutCubic, parent: animation));
        final fade = CurvedAnimation(parent: animation, curve: Curves.easeIn);
        return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: offset, child: child));
      },
    );
  }
}
