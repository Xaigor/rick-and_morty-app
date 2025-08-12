import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/models/character.dart';
import 'package:rick_and_morty_app/ui/characters/widgets/character_info_card_widget.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;
  final String heroTag;
  const CharacterDetailScreen(
      {super.key, required this.character, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: Material(
                color: Colors.black87,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.of(context).maybePop(),
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
            ),
            expandedHeight: 320,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              // title:
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                      tag: heroTag,
                      child: Image.network(character.image, fit: BoxFit.cover)),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Text(
                        character.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'WubbaLubbaDubDub',
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Color(0xFFFAFD7C),
                        ),
                      ),
                      Text(
                        character.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'WubbaLubbaDubDub',
                          color: Color(0xFF69C8EC),
                        ),
                      ),
                    ],
                  ),
                  CharacterInfoCardWidget(
                    title: "Espécie",
                    value: character.species,
                    icon: Icons.person,
                  ),
                  CharacterInfoCardWidget(
                    title: "Status",
                    value: character.status,
                    icon: Icons.favorite,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // appBar: AppBar(
      //     // title: Text(character.name),
      //     ),
      // body: Container(
      //   color: Theme.of(context).colorScheme.surface,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       SizedBox(
      //         width: double.infinity,
      //         child: Image.network(
      //           character.image,
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       Stack(
      //         children: [
      //           Text(
      //             character.name,
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               fontSize: 50,
      //               fontFamily: 'WubbaLubbaDubDub',
      //               foreground: Paint()
      //                 ..style = PaintingStyle.stroke
      //                 ..strokeWidth = 2
      //                 ..color = Color(0xFFFAFD7C),
      //             ),
      //           ),
      //           Text(
      //             character.name,
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               fontSize: 50,
      //               fontFamily: 'WubbaLubbaDubDub',
      //               color: Color(0xFF69C8EC),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           CharacterInfoCardWidget(
      //             title: "Espécie",
      //             value: character.species,
      //             icon: Icons.person,
      //           ),
      //           CharacterInfoCardWidget(
      //             title: "Status",
      //             value: character.status,
      //             icon: Icons.favorite,
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
