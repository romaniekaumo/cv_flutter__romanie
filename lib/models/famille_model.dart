class MembreFamille {
  final String id;
  final String nomComplet;
  final String lienParente;
  final String? photoAssetPath;
  final String? profession;
  final int? age;
  final String? description;
  final bool estExemple;

  const MembreFamille({
    required this.id,
    required this.nomComplet,
    required this.lienParente,
    this.photoAssetPath,
    this.profession,
    this.age,
    this.description,
    this.estExemple = true,
  });
}