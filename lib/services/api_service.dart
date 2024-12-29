import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:8085'; // Remplacez cette URL par votre API

  // Fonction pour récupérer les utilisateurs
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      // Si la requête est réussie, décoder le JSON
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Fonction pour ajouter un utilisateur
  Future<void> addUser(String name, String email, String avatar) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'name': name, 'email': email, 'avatar': avatar}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }
  }
}
