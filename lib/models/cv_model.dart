class FormationItem {
  final String etablissement;
  final String diplome;
  final String periode;
  final String optionDomaine;
  final bool estExemple;

  const FormationItem({
    required this.etablissement,
    required this.diplome,
    required this.periode,
    required this.optionDomaine,
    this.estExemple = true,
  });
}

class ExperienceItem {
  final String type; // Stage, Projet, Emploi
  final String titre;
  final String organisation;
  final String periode;
  final String description;
  final bool estExemple;

  const ExperienceItem({
    required this.type,
    required this.titre,
    required this.organisation,
    required this.periode,
    required this.description,
    this.estExemple = true,
  });
}

class CompetenceTechnique {
  final String categorie;
  final String niveauOuDetails;
  final bool estExemple;

  const CompetenceTechnique({
    required this.categorie,
    required this.niveauOuDetails,
    this.estExemple = true,
  });
}

class CompetenceLinguistique {
  final String langue;
  final String niveau;
  final bool estExemple;

  const CompetenceLinguistique({
    required this.langue,
    required this.niveau,
    this.estExemple = true,
  });
}

class CentreInteret {
  final String libelle;
  final bool estExemple;

  const CentreInteret({
    required this.libelle,
    this.estExemple = true,
  });
}

class ContactInfo {
  final String telephone;
  final String email;
  final String adressePhysique;
  final String? requeteCarte;
  final String linkedinUrl;
  final String githubUrl;
  final Map<String, String> autresReseaux;
  final bool estExemple;

  const ContactInfo({
    required this.telephone,
    required this.email,
    required this.adressePhysique,
    this.requeteCarte,
    required this.linkedinUrl,
    required this.githubUrl,
    this.autresReseaux = const {},
    this.estExemple = true,
  });
}

class CvProfile {
  final String nomComplet;
  final String titreProfessionnel;
  final String presentationCourte;
  final String photoAssetPath;
  final List<FormationItem> formations;
  final List<ExperienceItem> experiences;
  final List<CompetenceTechnique> competencesTechniques;
  final List<CompetenceLinguistique> langues;
  final List<CentreInteret> centresInteret;
  final ContactInfo contact;

  const CvProfile({
    required this.nomComplet,
    required this.titreProfessionnel,
    required this.presentationCourte,
    required this.photoAssetPath,
    required this.formations,
    required this.experiences,
    required this.competencesTechniques,
    required this.langues,
    required this.centresInteret,
    required this.contact,
  });
}