import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/ui/characters/view_model/characters_view_model.dart';
import 'package:rick_and_morty_app/ui/characters/widgets/character_card_widget.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late CharactersViewModel vm;
  int page = 1;

  @override
  void initState() {
    vm = CharactersViewModel(context.read());
    vm.getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  ValueListenableBuilder(
                    valueListenable: vm,
                    builder: (context, value, child) {
                      if (value is CharactersLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (value is CharactersErrorState) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Algo deu errado.'),
                              const SizedBox(height: 8),
                              FilledButton.icon(
                                onPressed: vm.getCharacters,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Tentar novamente'),
                              )
                            ],
                          ),
                        );
                      }
                      if (value is CharactersLoadedState) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: .72,
                          ),
                          itemCount: value.characters.length,
                          itemBuilder: (context, index) {
                            final character = value.characters[index];
                            final heroTag = 'img_${character.image}';
                            return CharacterCardWidget(
                              onTap: (AnimationController controller) =>
                                  vm.selectCharacter(
                                      context, character, controller, heroTag),
                              character: character,
                              heroTag: heroTag,
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: vm,
              builder: (context, _, __) {
                return Container(
                  color: Colors.black,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: vm.previousPage != null
                                  ? vm.changeToPreviousPage
                                  : null,
                              child: const Icon(Icons.arrow_back_ios,
                                  color: Color(0xFF97CE4C)),
                            ),
                            ...(() {
                              final start = ((vm.page - 1) ~/ 3) * 3 + 1;
                              return [
                                styleButton(vm.page, start),
                                styleButton(vm.page, start + 1),
                                styleButton(vm.page, start + 2),
                              ];
                            }()),
                            OutlinedButton(
                              onPressed: vm.nextPage != null
                                  ? vm.changeToNextPage
                                  : null,
                              child: const Icon(Icons.arrow_forward_ios,
                                  color: Color(0xFF97CE4C)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }

  styleButton(int selectedPage, int page) {
    bool selected = selectedPage == page;
    if (page > vm.totalPages) return Container();
    return GestureDetector(
      onTap: () => vm.changePage(page),
      child: Container(
        width: 35,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: selected
              ? DecorationImage(
                  image: AssetImage('assets/portal.png'),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Center(
          child: Text(page.toString(),
              style: TextStyle(
                fontSize: 22,
                color: selected ? Colors.black : Color(0xFF97CE4C),
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
