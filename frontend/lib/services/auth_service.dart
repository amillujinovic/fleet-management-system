import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'api_client.dart';
class AuthService
{
   Future<AuthResult> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
    final response = await ApiClient.post('Auth/login', {
      'email': email,
      'password': password,
    });
    final data=ApiClient.parseResponse(response);
    final String token= data['token'] ?? data['accessToken'] ?? data['jwt']?? '';
    if (token.isEmpty) {
      throw Exception('Token not found in response');
    }
    await saveToken(token);
    final userJson = data['user'] ?? data;
    final user = User.fromJson(userJson);
    return AuthResult(token: token, user: user);
}
Future<void> Register({
  required String name,
  required String email,
  required String password,
}) async {
  final response = await ApiClient.post('Auth/register', {
    'name': name,
    'email': email,
    'password': password,
  });
  ApiClient.parseResponse(response);
}
Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
Future<void> saveToken(String token) async
{
  final prefs = await SharedPreferences.getInstance();
  //SharedPreferences is used to store simple key-value pairs persistently. 
  await prefs.setString('auth_token', token);
}
Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
  class AuthResult
  {
    final String token;
    final User user;
    AuthResult({required this.token,required this.user});
  }
