
import 'dart:typed_data';

class MembreFamille {
  final String id;
  final String nom;
  final String postnom;
  final String prenom;
  final String lieuNaissance;
  final String dateNaissance;
  final String parente;
  final String? photoAssetPath;
  final Uint8List? photoBytes;
  final String? imageUrl;

  MembreFamille({
    required this.id,
    required this.nom,
    required this.postnom,
    required this.prenom,
    required this.lieuNaissance,
    required this.dateNaissance,
    required this.parente,
    this.photoAssetPath,
    this.photoBytes,
    this.imageUrl,
  });

  String get nomComplet => '$nom $postnom $prenom';

  String get lienParente => parente;

  factory MembreFamille.fromJson(Map<String, dynamic> json) {
    return MembreFamille(
      id: json['id'].toString(),
      nom: json['nom'] ?? '',
      postnom: json['postnom'] ?? '',
      prenom: json['prenom'] ?? '',
      lieuNaissance: json['lieu_naissance'] ?? '',
      dateNaissance: json['date_naissance'] ?? '',
      parente: json['parente'] ?? '',
      imageUrl: json['image_url']?.toString(),
    );
  }
}
