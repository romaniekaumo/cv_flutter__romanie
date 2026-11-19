import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      backgroundColor: AppColors.pureWhite,
      indicatorColor: AppColors.softLightBlue,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: AppColors.primaryDarkBlue),
          label: 'Accueil',
        ),
        NavigationDestination(
          icon: Icon(Icons.description_outlined),
          selectedIcon: Icon(Icons.description, color: AppColors.primaryDarkBlue),
          label: 'Mon CV',
        ),
        NavigationDestination(
          icon: Icon(Icons.family_restroom_outlined),
          selectedIcon: Icon(Icons.family_restroom, color: AppColors.primaryDarkBlue),
          label: 'Famille',
        ),
        NavigationDestination(
          icon: Icon(Icons.contact_mail_outlined),
          selectedIcon: Icon(Icons.contact_mail, color: AppColors.primaryDarkBlue),
          label: 'Contact',
        ),
      ],
    );
  }
}

class AppNavigationDrawer extends StatelessWidget {
  final int currentIndex;
  final String? username;
  final ValueChanged<int> onSelectTab;
  final VoidCallback onLogout;

  const AppNavigationDrawer({
    super.key,
    required this.currentIndex,
    required this.username,
    required this.onSelectTab,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        Navigator.pop(context);
        onSelectTab(index);
      },
      backgroundColor: AppColors.pureWhite,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: AppColors.primaryDarkBlue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.badge_outlined, color: AppColors.pureWhite, size: 36),
              SizedBox(height: 8),
              Text(
                'Mon CV Personnel',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'KAUMO KIPONGO ROMANIE',
                style: TextStyle(color: Color(0xFFBFDBFE), fontSize: 12),
              ),
            ],
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          label: Text('Accueil'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.description_outlined),
          label: Text('Mon CV'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.family_restroom_outlined),
          label: Text('Famille'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.contact_mail_outlined),
          label: Text('Contact'),
        ),
        const Divider(indent: 16, endIndent: 16),
        ListTile(
          leading: const Icon(Icons.logout, color: AppColors.errorRed),
          title: const Text(
            'Déconnexion',
            style: TextStyle(
              color: AppColors.errorRed,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: username != null ? Text('Connecté : $username') : null,
          onTap: () {
            Navigator.pop(context);
            onLogout();
          },
        ),
      ],
    );
  }
}