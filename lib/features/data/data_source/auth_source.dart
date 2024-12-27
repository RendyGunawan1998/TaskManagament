import 'package:http/http.dart' as http;
import '../../../core.dart';

class AuthDataSource {
  final http.Client client;

  AuthDataSource({required this.client});

  Future<LoginResponse> login(String email, String password) async {
    final response = await client.post(
      Uri.parse(LOGIN_URL),
      body: {'email': email, 'password': password},
    );
    print('S.code login :: ${response.statusCode}');

    if (response.statusCode == 200) {
      Get.offAll(() => ListTaskScreen());
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<RegisterResponse> register(
      String email, String password, String username) async {
    print('email :: $email');
    print('password :: $password');
    print('username :: $username');
    final response = await client.post(
      Uri.parse(REGIS_URL),
      headers: {
        'accept': 'application/json',
      },
      body: {
        'email': email,
        'password': password,
        "username": username,
      },
    );
    print('S.code register :: ${response.statusCode}');

    if (response.statusCode == 200) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }
}
