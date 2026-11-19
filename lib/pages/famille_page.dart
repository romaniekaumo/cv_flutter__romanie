import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/famille_model.dart';
import '../widgets/famille_card.dart';

class FamillePage extends StatefulWidget {
  final List<MembreFamille> membres;
  final ValueChanged<MembreFamille> onAddMembre;
  final ValueChanged<String> onRemoveMembre;

  const FamillePage({
    super.key,
    required this.membres,
    required this.onAddMembre,
    required this.onRemoveMembre,
  });

  @override
  State<FamillePage> createState() => _FamillePageState();
}

class _FamillePageState extends State<FamillePage> {
  void _openAddMemberDialog() {
    final nomController = TextEditingController();
    final lienController = TextEditingController();
    final professionController = TextEditingController();
    final ageController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ajouter un membre de la famille'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom complet *',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: lienController,
                decoration: const InputDecoration(
                  labelText: 'Lien de parenté *',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: professionController,
                decoration: const InputDecoration(
                  labelText: 'Profession (facultatif)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Âge (facultatif)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Description (facultatif)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () {
              final nom = nomController.text.trim();
              final lien = lienController.text.trim();
              if (nom.isEmpty || lien.isEmpty) return;

              final parsedAge = int.tryParse(ageController.text.trim());
              final nouveauMembre = MembreFamille(
                id: 'membre_${DateTime.now().millisecondsSinceEpoch}',
                nomComplet: nom,
                lienParente: lien,
                photoAssetPath: null,
                profession: professionController.text.trim().isEmpty
                    ? null
                    : professionController.text.trim(),
                age: parsedAge,
                description: descriptionController.text.trim().isEmpty
                    ? null
                    : descriptionController.text.trim(),
                estExemple: false,
              );

              widget.onAddMembre(nouveauMembre);
              Navigator.pop(ctx);
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddMemberDialog,
        backgroundColor: AppColors.primaryDarkBlue,
        foregroundColor: AppColors.pureWhite,
        icon: const Icon(Icons.person_add),
        label: const Text('Ajouter'),
      ),
      body: widget.membres.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Aucun membre enregistré pour le moment.\nAppuyez sur « Ajouter » pour en ajouter un.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 84),
              itemCount: widget.membres.length,
              itemBuilder: (context, index) {
                final membre = widget.membres[index];
                return FamilleCard(
                  membre: membre,
                  onDelete: () => widget.onRemoveMembre(membre.id),
                );
              },
            ),
    );
  }
}