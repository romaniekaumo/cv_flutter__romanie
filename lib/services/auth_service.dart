
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  bool _isAuthenticated = false;
  String? _currentUser;

  bool get isAuthenticated => _isAuthenticated;
  String? get currentUser => _currentUser;

  // Connexion avec l'API PHP
  Future<String?> login({
    required String identifier,
    required String password,
  }) async {
    final email = identifier.trim();

    if (email.isEmpty || password.isEmpty) {
      return 'Veuillez remplir l\'e-mail et le mot de passe.';
    }

    try {
      final resultat = await _apiService.connecterUtilisateur(
        email,
        password,
      );

      final donnees = resultat['data'];

      _isAuthenticated = true;
      _currentUser = donnees['email']?.toString() ?? email;

      return null;
    } catch (e) {
      _isAuthenticated = false;
      _currentUser = null;

      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  // Déconnexion
  void logout() {
    _isAuthenticated = false;
    _currentUser = null;
  }
}
