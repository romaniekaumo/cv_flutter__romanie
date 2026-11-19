/// Service d'authentification de démonstration.
/// Identifiants par défaut (à adapter selon vos besoins) :
/// - Identifiant : romanie
/// - Mot de passe : CvFlutter2026!
class AuthService {
  static const String demoUsername = 'romanie';
  static const String demoPassword = 'CvFlutter2026!';

  bool _isAuthenticated = false;
  String? _currentUser;

  bool get isAuthenticated => _isAuthenticated;
  String? get currentUser => _currentUser;

  String? login({
    required String identifier,
    required String password,
  }) {
    final cleanId = identifier.trim();
    if (cleanId.isEmpty || password.isEmpty) {
      return 'Veuillez remplir l\'identifiant et le mot de passe.';
    }

    if (cleanId.toLowerCase() == demoUsername.toLowerCase() &&
        password == demoPassword) {
      _isAuthenticated = true;
      _currentUser = cleanId;
      return null; // Succès
    }

    _isAuthenticated = false;
    _currentUser = null;
    return 'Identifiant ou mot de passe incorrect (démo : romanie / CvFlutter2026!).';
  }

  void logout() {
    _isAuthenticated = false;
    _currentUser = null;
  }
}