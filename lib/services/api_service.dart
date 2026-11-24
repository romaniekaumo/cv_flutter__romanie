import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://localhost/api-test/public';

  // Vérifier la connexion à l'API
  Future<bool> testerConnexion() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/famille-membres'),
      );

      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Erreur API : $e');
      return false;
    }
  }

  // Créer un compte
  Future<Map<String, dynamic>> inscrireUtilisateur(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/accounts/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return _traiterReponse(response);
  }

  // Connecter un utilisateur
  Future<Map<String, dynamic>> connecterUtilisateur(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/accounts/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return _traiterReponse(response);
  }

  // Charger les membres de famille
  Future<List<dynamic>> obtenirFamille() async {
    final response = await http.get(
      Uri.parse('$baseUrl/famille-membres'),
    );

    final resultat = _traiterReponse(response);
    return resultat['data'] as List<dynamic>;
  }

  // Ajouter un membre avec sa photo
  Future<Map<String, dynamic>> ajouterMembre(
    Map<String, dynamic> membre, {
    Uint8List? image,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/famille-membres'),
    );

    membre.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    if (image != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image,
          filename: 'photo.jpg',
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(
      streamedResponse,
    );

    return _traiterReponse(response);
  }

  // Modifier un membre avec ou sans nouvelle photo
  Future<Map<String, dynamic>> modifierMembre(
    int id,
    Map<String, dynamic> membre, {
    Uint8List? image,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/famille-membres/$id'),
    );

    membre.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    if (image != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image,
          filename: 'photo.jpg',
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(
      streamedResponse,
    );

    return _traiterReponse(response);
  }

  // Supprimer un membre
  Future<void> supprimerMembre(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/famille-membres/$id'),
    );

    _traiterReponse(response);
  }

  // Traiter les réponses de l'API
  Map<String, dynamic> _traiterReponse(
    http.Response response,
  ) {
    final resultat = jsonDecode(response.body);

    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        resultat['success'] == true) {
      return Map<String, dynamic>.from(resultat);
    }

    throw Exception(
      resultat['message'] ?? 'Une erreur est survenue',
    );
  }
}
