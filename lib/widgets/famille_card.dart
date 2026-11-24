
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/famille_model.dart';

class FamilleCard extends StatelessWidget {
  final MembreFamille membre;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const FamilleCard({
    super.key,
    required this.membre,
    required this.onEdit,
    required this.onDelete,
  });

  Widget _buildAvatar() {
    // 1. Photo sélectionnée sur l'appareil
    if (membre.photoBytes != null) {
      return CircleAvatar(
        radius: 30,
        backgroundImage: MemoryImage(membre.photoBytes!),
      );
    }

    // 2. Photo récupérée depuis le serveur PHP
    if (membre.imageUrl != null && membre.imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.softLightBlue,
        child: ClipOval(
          child: Image.network(
            membre.imageUrl!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.person,
              color: AppColors.primaryDarkBlue,
              size: 30,
            ),
          ),
        ),
      );
    }

    // 3. Ancienne photo locale
    if (membre.photoAssetPath != null &&
        membre.photoAssetPath!.isNotEmpty) {
      return CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.softLightBlue,
        child: ClipOval(
          child: Image.asset(
            membre.photoAssetPath!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.person,
              color: AppColors.primaryDarkBlue,
              size: 30,
            ),
          ),
        ),
      );
    }

    // 4. Avatar par défaut
    return const CircleAvatar(
      radius: 30,
      backgroundColor: AppColors.softLightBlue,
      child: Icon(
        Icons.person,
        color: AppColors.primaryDarkBlue,
        size: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          membre.nomComplet,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onEdit,
                        tooltip: 'Modifier ce membre',
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: AppColors.primaryDarkBlue,
                          size: 20,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                      IconButton(
                        onPressed: onDelete,
                        tooltip: 'Supprimer ce membre',
                        icon: const Icon(
                          Icons.delete_outline,
                          color: AppColors.errorRed,
                          size: 20,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softLightBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      membre.lienParente,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDarkBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lieu de naissance : ${membre.lieuNaissance}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Date de naissance : ${membre.dateNaissance}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
