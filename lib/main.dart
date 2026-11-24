
import 'package:flutter/material.dart';

import 'app_data.dart';
import 'constants/app_colors.dart';
import 'models/famille_model.dart';
import 'pages/accueil_page.dart';
import 'pages/contact_page.dart';
import 'pages/famille_page.dart';
import 'pages/login_page.dart';
import 'services/auth_service.dart';
import 'services/api_service.dart';
import 'widgets/navigation_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CvPersonnelApp());
}

class CvPersonnelApp extends StatefulWidget {
  const CvPersonnelApp({super.key});

  @override
  State<CvPersonnelApp> createState() => _CvPersonnelAppState();
}

class _CvPersonnelAppState extends State<CvPersonnelApp> {
  final AuthService _authService = AuthService();
  final ApiService _apiService = ApiService();

  int _selectedIndex = 0;

  final List<MembreFamille> _membresFamille = [];

  static const List<String> _pageTitles = [
    'Accueil',
    'Mon CV',
    'Famille',
    'Contact',
  ];

  // Charger les membres depuis l'API
  Future<void> _chargerFamille() async {
    try {
      final donnees = await _apiService.obtenirFamille();

      final membres = donnees.map((item) {
        return MembreFamille.fromJson(
          Map<String, dynamic>.from(item),
        );
      }).toList();

      if (!mounted) return;

      setState(() {
        _membresFamille
          ..clear()
          ..addAll(membres);
      });
    } catch (e) {
      debugPrint('Erreur de chargement : $e');
    }
  }

  // Après la connexion
  void _onLoginSuccess() {
    setState(() {
      _selectedIndex = 0;
    });

    _chargerFamille();
  }

  // Déconnexion
  void _onLogout() {
    _authService.logout();

    setState(() {
      _selectedIndex = 0;
    });
  }

  // Ajouter un membre avec sa photo
  Future<void> _addMembre(MembreFamille membre) async {
    try {
      await _apiService.ajouterMembre(
        {
          'nom': membre.nom,
          'postnom': membre.postnom,
          'prenom': membre.prenom,
          'lieu_naissance': membre.lieuNaissance,
          'date_naissance': membre.dateNaissance,
          'parente': membre.parente,
        },
        image: membre.photoBytes,
      );

      await _chargerFamille();
    } catch (e) {
      debugPrint('Erreur lors de l’ajout : $e');
    }
  }

  // Modifier un membre avec sa photo
  Future<void> _editMembre(MembreFamille membre) async {
    try {
      await _apiService.modifierMembre(
        int.parse(membre.id),
        {
          'nom': membre.nom,
          'postnom': membre.postnom,
          'prenom': membre.prenom,
          'lieu_naissance': membre.lieuNaissance,
          'date_naissance': membre.dateNaissance,
          'parente': membre.parente,
        },
        image: membre.photoBytes,
      );

      await _chargerFamille();
    } catch (e) {
      debugPrint('Erreur lors de la modification : $e');
    }
  }

  // Supprimer un membre
  Future<void> _removeMembre(String id) async {
    try {
      await _apiService.supprimerMembre(int.parse(id));

      await _chargerFamille();
    } catch (e) {
      debugPrint('Erreur lors de la suppression : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppData.appName,
      debugShowCheckedModeBanner: false,
      theme: AppColors.buildTheme(),

      home: !_authService.isAuthenticated
          ? LoginPage(
              authService: _authService,
              onLoginSuccess: _onLoginSuccess,
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(_pageTitles[_selectedIndex]),
                actions: [
                  IconButton(
                    onPressed: _onLogout,
                    tooltip: 'Déconnexion',
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),

              drawer: AppNavigationDrawer(
                currentIndex: _selectedIndex,
                username: _authService.currentUser,
                onSelectTab: (index) {
                  setState(() => _selectedIndex = index);
                },
                onLogout: _onLogout,
              ),

              body: IndexedStack(
                index: _selectedIndex,
                children: [
                  AccueilPage(
                    profile: AppData.profilCv,
                    focusCvFirst: false,
                    onGoToContact: () {
                      setState(() => _selectedIndex = 3);
                    },
                  ),

                  AccueilPage(
                    profile: AppData.profilCv,
                    focusCvFirst: true,
                    onGoToContact: () {
                      setState(() => _selectedIndex = 3);
                    },
                  ),

                  FamillePage(
                    membres: _membresFamille,
                    onAddMembre: _addMembre,
                    onEditMembre: _editMembre,
                    onRemoveMembre: _removeMembre,
                  ),

                  ContactPage(
                    contact: AppData.profilCv.contact,
                  ),
                ],
              ),

              bottomNavigationBar: AppBottomNav(
                currentIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
            ),
    );
  }
}
