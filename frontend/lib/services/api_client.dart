import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient
{
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://100.58.207.64:8080/api',
  );
  static Future<String?> _getToken() async
  {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  static Future<Map<String, String>> _buildHeaders() async
  {
    final token=await _getToken();
    return {
      'Content-Type':'application/json',
      'Accept':'application/json', //after getting token i here define that sending and accepting data is json
      if(token!=null) 'Authorization':'Bearer $token',
    };
  }
  //get
  static Future<http.Response> get(String endpoint) async
  {
    final url=Uri.parse('$baseUrl/$endpoint');
    try
    {
      return await http.get(url,headers: await _buildHeaders());
    }
    catch(e)
    {
      throw Exception('Failed to make GET request: $e');
    }
  }
  //post
  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      return await http.post(
        url,
        headers: await _buildHeaders(),
        body: json.encode(body),
      );
    } catch (e) {
      throw Exception('Network error (POST $endpoint): $e');
    }
  }
  //put
  static Future<http.Response> put(String endpoint,Map<String,dynamic> body) async
  {
    final url=Uri.parse('$baseUrl/$endpoint');
    try
    {
      return await http.put(url,headers: await _buildHeaders(),body: json.encode(body));
    }
    catch(e)
    {
      throw Exception('Failed to make PUT request: $e');
    }
  }
  //delete
  static Future<http.Response> delete(String endpoint) async
  {
    final url=Uri.parse('$baseUrl/$endpoint');
    try
    {
      return await http.delete(url,headers: await _buildHeaders());
    }
    catch(e)
    {
      throw Exception('Failed to make DELETE request: $e');
    }
  }
  static dynamic parseResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null; // npr. DELETE ne vraća tijelo
      return json.decode(response.body);
    } else {
      throw Exception(
        'API Error: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
