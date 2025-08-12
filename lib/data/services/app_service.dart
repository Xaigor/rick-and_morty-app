import 'api_client.dart';
import 'dio_api_client.dart';

class AppService {
  static const String defaultClient = 'dio';

  static const String baseUrl = 'https://rickandmortyapi.com/api';

  static ApiClient createApiClient({String? client}) {
    final which = (client ?? defaultClient).toLowerCase();
    switch (which) {
      // Local para troca de implementação de API Client
      case 'dio':
        return DioApiClient();
      default:
        return DioApiClient();
    }
  }
}
