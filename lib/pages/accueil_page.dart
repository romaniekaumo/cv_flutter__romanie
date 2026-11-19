import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/cv_model.dart';
import '../widgets/section_cv.dart';

class AccueilPage extends StatelessWidget {
  final CvProfile profile;
  final bool focusCvFirst;
  final VoidCallback onGoToContact;

  const AccueilPage({
    super.key,
    required this.profile,
    this.focusCvFirst = false,
    required this.onGoToContact,
  });

  Widget _buildProfilePhoto() {
    return CircleAvatar(
      radius: 46,
      backgroundColor: AppColors.softLightBlue,
      child: ClipOval(
        child: Image.asset(
          profile.photoAssetPath,
          width: 92,
          height: 92,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.person,
            size: 46,
            color: AppColors.primaryDarkBlue,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // A. Présentation personnelle
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryDarkBlue, AppColors.primaryBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _buildProfilePhoto(),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.nomComplet,
                          style: const TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          profile.titreProfessionnel,
                          style: const TextStyle(
                            color: Color(0xFFDBEAFE),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  profile.presentationCourte,
                  style: const TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: 13.5,
                    height: 1.4,
                  ),
                ),
              ),
              if (!focusCvFirst) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: onGoToContact,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.pureWhite,
                    ),
                    icon: const Icon(Icons.arrow_forward, size: 18),
                    label: const Text('Me contacter'),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),

        // B. Formation académique
        SectionCv(
          title: 'Formation académique',
          icon: Icons.school_outlined,
          child: Column(
            children: profile.formations
                .map(
                  (f) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.circle,
                      size: 9,
                      color: AppColors.lightBlue,
                    ),
                    title: Text(
                      f.diplome,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      '${f.etablissement} • ${f.optionDomaine}\n${f.periode}',
                    ),
                    isThreeLine: true,
                  ),
                )
                .toList(),
          ),
        ),

        // C. Expériences professionnelles
        SectionCv(
          title: 'Expériences professionnelles',
          icon: Icons.work_outline,
          child: Column(
            children: profile.experiences
                .map(
                  (e) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.circle,
                      size: 9,
                      color: AppColors.lightBlue,
                    ),
                    title: Text(
                      '${e.titre} (${e.type})',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      '${e.organisation} • ${e.periode}\n${e.description}',
                    ),
                    isThreeLine: true,
                  ),
                )
                .toList(),
          ),
        ),

        // D. Compétences techniques
        SectionCv(
          title: 'Compétences techniques',
          icon: Icons.code_outlined,
          child: Column(
            children: profile.competencesTechniques
                .map(
                  (c) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    leading: const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.primaryBlue,
                      size: 20,
                    ),
                    title: Text(
                      c.categorie,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(c.niveauOuDetails),
                  ),
                )
                .toList(),
          ),
        ),

        // E. Compétences linguistiques
        SectionCv(
          title: 'Compétences linguistiques',
          icon: Icons.translate_outlined,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: profile.langues
                .map(
                  (l) => Chip(
                    backgroundColor: AppColors.softLightBlue,
                    side: const BorderSide(color: AppColors.borderLight),
                    label: Text(
                      '${l.langue} — ${l.niveau}',
                      style: const TextStyle(color: AppColors.primaryDarkBlue),
                    ),
                  ),
                )
                .toList(),
          ),
        ),

        // F. Centres d'intérêt
        SectionCv(
          title: 'Centres d\'intérêt',
          icon: Icons.interests_outlined,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: profile.centresInteret
                .map(
                  (i) => Chip(
                    backgroundColor: AppColors.iceBlue,
                    side: const BorderSide(color: AppColors.borderLight),
                    label: Text(
                      i.libelle,
                      style: const TextStyle(color: AppColors.textDark),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}