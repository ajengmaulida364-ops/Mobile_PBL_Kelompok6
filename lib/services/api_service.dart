import 'package:http/http.dart' as http;

class ApiService {

  Future login({
    required String login,
    required String password,
  }) async {

    // NANTI CONNECT LARAVEL

    print(login);
    print(password);

  }
}