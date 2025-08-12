// Ajuste: Repositório agora depende do contrato ApiClient e usa AppService.baseUrl.
import 'package:rick_and_morty_app/data/model/character_api_model.dart';
import 'package:rick_and_morty_app/data/services/api_client.dart';
import 'package:rick_and_morty_app/data/services/app_service.dart';

class CharactersRepository {
  final ApiClient _client;
  final String _baseUrl;

  CharactersRepository(this._client, {String baseUrl = AppService.baseUrl})
      : _baseUrl = baseUrl;

  Future<List<ResultsCharacter>> getCharacters({int page = 1}) async {
    final response =
        await _client.get('$_baseUrl/character', query: {'page': page});
    final model = CharacterApiModel.fromJson(response);
    return model.results;
  }

  Future<dynamic> createSomething(Map<String, dynamic> data) async {
    return _client.post('$_baseUrl/some-resource', body: data);
  }
}
