import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/model/character_api_model.dart';
import 'package:rick_and_morty_app/data/repositories/characters_repository.dart';
import 'package:rick_and_morty_app/ui/characters/widgets/character_detail_screen.dart';

abstract class CharactersState {}

class CharactersLoadedState extends CharactersState {
  final List<ResultsCharacter> characters;
  CharactersLoadedState(this.characters);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharactersLoadedState && other.characters == characters;
  }

  @override
  int get hashCode => characters.hashCode;
}

class CharactersErrorState extends CharactersState {}

class CharactersLoadingState extends CharactersState {}

class CharactersInitialState extends CharactersState {}

class CharactersViewModel extends ValueNotifier<CharactersState> {
  final CharactersRepository repository;
  CharactersViewModel(this.repository) : super(CharactersInitialState());

  CharactersState get state => value;
  set state(CharactersState state) => value = state;

  int _page = 1;
  int get page => _page;
  set page(int page) {
    _page = page;
    notifyListeners();
  }

  Future<void> getCharacters() async {
    state = CharactersLoadingState();

    try {
      final characters = await repository.getCharacters(page: _page);
      state = CharactersLoadedState(characters);
    } catch (e) {
      state = CharactersErrorState();
    }
  }

  void changePage(int page) {
    _page = page;
    getCharacters();
  }

  void selectCharacter(BuildContext context, ResultsCharacter character) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterDetailScreen(character: character),
      ),
    );
  }

  void previousPage() {
    if (_page > 1) {
      _page--;
      getCharacters();
    }
  }

  void nextPage() {
    if (_page < 42) {
      _page++;
      getCharacters();
    }
  }
}
