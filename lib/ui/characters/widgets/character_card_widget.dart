import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/models/character.dart';
import 'package:rick_and_morty_app/ui/characters/widgets/character_detail_screen.dart';

class CharacterCardWidget extends StatefulWidget {
  final Character character;
  final String heroTag;
  const CharacterCardWidget(
      {super.key, required this.character, required this.heroTag});

  @override
  State<CharacterCardWidget> createState() => _CharacterCardWidgetState();
}

class _CharacterCardWidgetState extends State<CharacterCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 110));
    _scale = Tween(begin: 1.0, end: 0.96)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.character;
    return GestureDetector(
      onTapUp: (_) async {
        await _controller.reverse();
        Navigator.of(context).push(_buildDetailRoute(c, widget.heroTag));
      },
      child: ScaleTransition(
        scale: _scale,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Hero(
                  tag: widget.heroTag,
                  child: Image.network(c.image, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: Text(c.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PageRouteBuilder _buildDetailRoute(Character c, String heroTag) {
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
