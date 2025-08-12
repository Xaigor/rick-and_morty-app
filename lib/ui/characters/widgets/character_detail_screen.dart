import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/model/character_api_model.dart';

class CharacterDetailScreen extends StatelessWidget {
  final ResultsCharacter character;
  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: Container(
        color: Colors.grey[800],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(
                character.image,
                fit: BoxFit.cover,
              ),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  character.species,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFFFAFD7C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  character.status,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF97CE4C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
