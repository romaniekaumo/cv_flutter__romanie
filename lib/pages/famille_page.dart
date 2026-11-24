
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_colors.dart';
import '../models/famille_model.dart';
import '../widgets/famille_card.dart';

class FamillePage extends StatefulWidget {
  final List<MembreFamille> membres;
  final ValueChanged<MembreFamille> onAddMembre;
  final ValueChanged<MembreFamille> onEditMembre;
  final ValueChanged<String> onRemoveMembre;

  const FamillePage({
    super.key,
    required this.membres,
    required this.onAddMembre,
    required this.onEditMembre,
    required this.onRemoveMembre,
  });

  @override
  State<FamillePage> createState() => _FamillePageState();
}

class _FamillePageState extends State<FamillePage> {
  final ImagePicker _picker = ImagePicker();

  void _openMemberDialog({MembreFamille? membre}) {
    final nomController = TextEditingController(text: membre?.nom ?? '');
    final postnomController =
        TextEditingController(text: membre?.postnom ?? '');
    final prenomController =
        TextEditingController(text: membre?.prenom ?? '');
    final lieuController =
        TextEditingController(text: membre?.lieuNaissance ?? '');
    final dateController =
        TextEditingController(text: membre?.dateNaissance ?? '');
    final parenteController =
        TextEditingController(text: membre?.parente ?? '');

    Uint8List? photoSelectionnee = membre?.photoBytes;
    final modification = membre != null;

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, actualiser) {
            Future<void> choisirPhoto() async {
              final XFile? image = await _picker.pickImage(
                source: ImageSource.gallery,
                imageQuality: 80,
              );

              if (image != null) {
                final bytes = await image.readAsBytes();

                actualiser(() {
                  photoSelectionnee = bytes;
                });
              }
            }

            return AlertDialog(
              title: Text(
                modification
                    ? 'Modifier un membre'
                    : 'Ajouter un membre de la famille',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: choisirPhoto,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: photoSelectionnee != null
                            ? MemoryImage(photoSelectionnee!)
                            : null,
                        child: photoSelectionnee == null
                            ? const Icon(
                                Icons.camera_alt,
                                size: 35,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: choisirPhoto,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Choisir une photo'),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: nomController,
                      decoration:
                          const InputDecoration(labelText: 'Nom *'),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: postnomController,
                      decoration:
                          const InputDecoration(labelText: 'Postnom *'),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: prenomController,
                      decoration:
                          const InputDecoration(labelText: 'Prénom *'),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: lieuController,
                      decoration: const InputDecoration(
                        labelText: 'Lieu de naissance *',
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        labelText: 'Date de naissance *',
                        hintText: 'AAAA-MM-JJ',
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: parenteController,
                      decoration: const InputDecoration(
                        labelText: 'Lien de parenté *',
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
                    final postnom = postnomController.text.trim();
                    final prenom = prenomController.text.trim();
                    final lieu = lieuController.text.trim();
                    final date = dateController.text.trim();
                    final parente = parenteController.text.trim();

                    if (nom.isEmpty ||
                        postnom.isEmpty ||
                        prenom.isEmpty ||
                        lieu.isEmpty ||
                        date.isEmpty ||
                        parente.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Veuillez remplir tous les champs.',
                          ),
                        ),
                      );
                      return;
                    }

                    final nouveauMembre = MembreFamille(
                      id: membre?.id ?? '',
                      nom: nom,
                      postnom: postnom,
                      prenom: prenom,
                      lieuNaissance: lieu,
                      dateNaissance: date,
                      parente: parente,
                      photoBytes: photoSelectionnee,
                    );

                    if (modification) {
                      widget.onEditMembre(nouveauMembre);
                    } else {
                      widget.onAddMembre(nouveauMembre);
                    }

                    Navigator.pop(ctx);
                  },
                  child: Text(
                    modification ? 'Enregistrer' : 'Ajouter',
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      nomController.dispose();
      postnomController.dispose();
      prenomController.dispose();
      lieuController.dispose();
      dateController.dispose();
      parenteController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openMemberDialog(),
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
                  'Aucun membre enregistré pour le moment.\n'
                  'Appuyez sur « Ajouter » pour en ajouter un.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textMuted,
                  ),
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
                  onEdit: () {
                    _openMemberDialog(membre: membre);
                  },
                  onDelete: () {
                    widget.onRemoveMembre(membre.id);
                  },
                );
              },
            ),
    );
  }
}
