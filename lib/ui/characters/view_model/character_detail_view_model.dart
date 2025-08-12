import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/model/character_api_model.dart';

class CharacterDetailViewModel extends ChangeNotifier {
  final ResultsCharacter character;

  CharacterDetailViewModel({required this.character});

  void getCharacter() {
    notifyListeners();
  }
}
