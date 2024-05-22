import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['categories'];
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<dynamic>> fetchMealsByCategory(String categoryName) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=$categoryName'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['meals'];
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
