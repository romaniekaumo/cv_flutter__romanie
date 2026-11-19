import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../models/cv_model.dart';
import '../widgets/section_cv.dart';

class ContactPage extends StatelessWidget {
  final ContactInfo contact;

  const ContactPage({super.key, required this.contact});

  Future<void> _openUri(BuildContext context, Uri uri) async {
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Impossible d\'ouvrir : ${uri.toString()}'),
        ),
      );
    }
  }

  void _callPhone(BuildContext context) {
    final cleaned = contact.telephone.replaceAll(RegExp(r'[^+\d]'), '');
    if (cleaned.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('0995703262')),
      );
      return;
    }
    _openUri(context, Uri(scheme: 'tel', path: cleaned));
  }

  void _sendEmail(BuildContext context) {
    final emailMatch = RegExp(r'[\w.+-]+@[\w-]+\.[\w.-]+').firstMatch(contact.email);
    final emailAddress = emailMatch?.group(0);
    if (emailAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('romaniekaumo21@gmail.com')),
      );
      return;
    }
    _openUri(
      context,
      Uri(
        scheme: 'mailto',
        path: emailAddress,
        queryParameters: {'subject': 'Contact — CV KAUMO KIPONGO ROMANIE'},
      ),
    );
  }

  void _openMap(BuildContext context) {
    final query = (contact.requeteCarte?.isNotEmpty == true)
        ? contact.requeteCarte!
        : contact.adressePhysique;
    final mapsUri = Uri.https(
      'www.google.com',
      '/maps/search/',
      {'api': '1', 'query': query},
    );
    _openUri(context, mapsUri);
  }

  void _openExternalUrl(BuildContext context, String rawUrl) {
    final uri = Uri.tryParse(rawUrl.trim());
    if (uri == null || (!uri.hasScheme)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lien invalide ou à compléter.')),
      );
      return;
    }
    _openUri(context, uri);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionCv(
          title: 'Coordonnées directes',
          icon: Icons.contact_phone_outlined,
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.phone, color: AppColors.primaryBlue),
                title: const Text('Téléphone'),
                subtitle: Text(contact.telephone),
                trailing: IconButton(
                  icon: const Icon(Icons.call, color: AppColors.primaryDarkBlue),
                  tooltip: 'Appeler',
                  onPressed: () => _callPhone(context),
                ),
                onTap: () => _callPhone(context),
              ),
              const Divider(height: 1, color: AppColors.borderLight),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.email, color: AppColors.primaryBlue),
                title: const Text('Adresse e-mail'),
                subtitle: Text(contact.email),
                trailing: IconButton(
                  icon: const Icon(Icons.send, color: AppColors.primaryDarkBlue),
                  tooltip: 'Envoyer un e-mail',
                  onPressed: () => _sendEmail(context),
                ),
                onTap: () => _sendEmail(context),
              ),
              const Divider(height: 1, color: AppColors.borderLight),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.location_on,
                  color: AppColors.primaryBlue,
                ),
                title: const Text('Adresse physique'),
                subtitle: Text(contact.adressePhysique),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.map_outlined,
                    color: AppColors.primaryDarkBlue,
                  ),
                  tooltip: 'Ouvrir la carte',
                  onPressed: () => _openMap(context),
                ),
                onTap: () => _openMap(context),
              ),
            ],
          ),
        ),
        SectionCv(
          title: 'Réseaux professionnels & sociaux',
          icon: Icons.share_outlined,
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.work, color: AppColors.primaryBlue),
                title: const Text('LinkedIn'),
                subtitle: Text(contact.linkedinUrl),
                trailing: const Icon(
                  Icons.open_in_new,
                  color: AppColors.primaryDarkBlue,
                ),
                onTap: () => _openExternalUrl(context, contact.linkedinUrl),
              ),
              const Divider(height: 1, color: AppColors.borderLight),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.code, color: AppColors.primaryBlue),
                title: const Text('GitHub'),
                subtitle: Text(contact.githubUrl),
                trailing: const Icon(
                  Icons.open_in_new,
                  color: AppColors.primaryDarkBlue,
                ),
                onTap: () => _openExternalUrl(context, contact.githubUrl),
              ),
              ...contact.autresReseaux.entries.map(
                (entry) => Column(
                  children: [
                    const Divider(height: 1, color: AppColors.borderLight),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.link,
                        color: AppColors.primaryBlue,
                      ),
                      title: Text(entry.key),
                      subtitle: Text(entry.value),
                      trailing: const Icon(
                        Icons.open_in_new,
                        color: AppColors.primaryDarkBlue,
                      ),
                      onTap: () => _openExternalUrl(context, entry.value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}