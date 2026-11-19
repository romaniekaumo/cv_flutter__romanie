import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/famille_model.dart';

class FamilleCard extends StatelessWidget {
  final MembreFamille membre;
  final VoidCallback onDelete;

  const FamilleCard({
    super.key,
    required this.membre,
    required this.onDelete,
  });

  Widget _buildAvatar() {
    final hasAsset =
        membre.photoAssetPath != null && membre.photoAssetPath!.isNotEmpty;
    if (!hasAsset) {
      return const CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.softLightBlue,
        child: Icon(Icons.person, color: AppColors.primaryDarkBlue, size: 30),
      );
    }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  if (membre.profession != null &&
                      membre.profession!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Profession : ${membre.profession}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                  if (membre.age != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Âge : ${membre.age} ans',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                  if (membre.description != null &&
                      membre.description!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      membre.description!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}