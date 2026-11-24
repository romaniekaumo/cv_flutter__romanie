
import 'dart:convert';
import 'package:http/http.dart' as http;

class CrudService {
  static const String baseUrl = 'http://localhost:3000';

  // Afficher
  Future<List<dynamic>> afficher(
      String table, int utilisateurId) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/api/$table?utilisateur_id=$utilisateurId',
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('Erreur lors du chargement');
  }

  // Ajouter
  Future<Map<String, dynamic>> ajouter(
      String table, Map<String, dynamic> donnees) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/$table'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(donnees),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }

    throw Exception(response.body);
  }

  // Modifier
  Future<Map<String, dynamic>> modifier(
      String table,
      int id,
      Map<String, dynamic> donnees) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/$table/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(donnees),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(response.body);
  }

  // Supprimer
  Future<bool> supprimer(
      String table, int id, int utilisateurId) async {
    final response = await http.delete(
      Uri.parse(
        '$baseUrl/api/$table/$id?utilisateur_id=$utilisateurId',
      ),
    );

    return response.statusCode == 200;
  }
}
