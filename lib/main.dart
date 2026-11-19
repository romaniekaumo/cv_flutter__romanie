import 'package:flutter/material.dart';
import 'app_data.dart';
import 'constants/app_colors.dart';
import 'models/famille_model.dart';
import 'pages/accueil_page.dart';
import 'pages/contact_page.dart';
import 'pages/famille_page.dart';
import 'pages/login_page.dart';
import 'services/auth_service.dart';
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
  int _selectedIndex = 0;
  final List<MembreFamille> _membresFamille =
      List<MembreFamille>.from(AppData.membresFamilleInitial);

  static const List<String> _pageTitles = [
    'Accueil',
    'Mon CV',
    'Famille',
    'Contact',
  ];

  void _onLoginSuccess() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  void _onLogout() {
    _authService.logout();
    setState(() {
      _selectedIndex = 0;
    });
  }

  void _addMembre(MembreFamille membre) {
    setState(() {
      _membresFamille.add(membre);
    });
  }

  void _removeMembre(String id) {
    setState(() {
      _membresFamille.removeWhere((m) => m.id == id);
    });
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
                onSelectTab: (index) => setState(() => _selectedIndex = index),
                onLogout: _onLogout,
              ),
              body: IndexedStack(
                index: _selectedIndex,
                children: [
                  AccueilPage(
                    profile: AppData.profilCv,
                    focusCvFirst: false,
                    onGoToContact: () => setState(() => _selectedIndex = 3),
                  ),
                  AccueilPage(
                    profile: AppData.profilCv,
                    focusCvFirst: true,
                    onGoToContact: () => setState(() => _selectedIndex = 3),
                  ),
                  FamillePage(
                    membres: _membresFamille,
                    onAddMembre: _addMembre,
                    onRemoveMembre: _removeMembre,
                  ),
                  ContactPage(contact: AppData.profilCv.contact),
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
