import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/repositories/characters_repository.dart';
import 'package:rick_and_morty_app/domain/models/character.dart';
import 'package:rick_and_morty_app/ui/characters/widgets/character_detail_screen.dart';

abstract class CharactersState {}

class CharactersLoadedState extends CharactersState {
  final List<Character> characters;
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

  bool _isLoading = false;
  int _page = 1;
  int _totalPages = 1;
  String? _previousPage;
  String? _nextPage;
  int get page => _page;
  int get totalPages => _totalPages;
  String? get previousPage => _previousPage;
  String? get nextPage => _nextPage;

  set page(int page) {
    _page = page;
    notifyListeners();
  }

  Future<void> getCharacters() async {
    if (_isLoading) return;
    _isLoading = true;
    state = CharactersLoadingState();

    try {
      final model = await repository.getCharacters(page: _page); // DTO
      _totalPages = model.info.pages;
      _previousPage = model.info.prev;
      _nextPage = model.info.next;

      final characters = model.results
          .map((e) => Character(
                name: e.name,
                image: e.image,
                status: e.status,
                species: e.species,
              ))
          .toList();

      state = CharactersLoadedState(characters);
    } catch (e) {
      state = CharactersErrorState();
    } finally {
      _isLoading = false;
    }
  }

  void changePage(int page) {
    _page = page.clamp(1, _totalPages);
    getCharacters();
  }

  void changeToPreviousPage() {
    if (_page > 1) {
      _page--;
      getCharacters();
    }
  }

  void changeToNextPage() {
    if (_page < _totalPages) {
      _page++;
      getCharacters();
    }
  }

  void selectCharacter(BuildContext context, Character character,
      AnimationController controller, String heroTag) async {
    await controller.reverse();
    Navigator.of(context).push(_buildDetailRoute(character, heroTag));
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
