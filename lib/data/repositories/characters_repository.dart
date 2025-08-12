import 'package:rick_and_morty_app/data/model/character_api_model.dart';
import 'package:rick_and_morty_app/data/services/api_client.dart';
import 'package:rick_and_morty_app/data/services/app_service.dart';

class CharactersRepository {
  final ApiClient _client;
  final String _baseUrl;

  CharactersRepository(this._client, {String baseUrl = AppService.baseUrl})
      : _baseUrl = baseUrl;

  // Ajuste: retorna o DTO completo da API
  Future<CharacterApiModel> getCharacters({int page = 1}) async {
    final response =
        await _client.get('$_baseUrl/character', query: {'page': page});
    return CharacterApiModel.fromJson(response);
  }
}
