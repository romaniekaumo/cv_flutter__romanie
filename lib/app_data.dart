import 'models/cv_model.dart';
import 'models/famille_model.dart';

/// Données centralisées de l'application.
/// Les champs marqués `estExemple: true` sont des modèles à remplacer
/// par vos informations réelles avant publication définitive.
class AppData {
  AppData._();

  static const String appName = 'Mon CV Personnel';
  static const String repoName = 'cv_flutter_kaumo_kipongo_romanie';
  static const String githubRepoUrl =
      'https://github.com/TON_USERNAME/cv_flutter_kaumo_kipongo_romanie';

  static final CvProfile profilCv = CvProfile(
    nomComplet: 'KAUMO KIPONGO ROMANIE',
    titreProfessionnel:
        'Développeur Flutter',
    presentationCourte:
        'Etudiante en lincence informatique applique à la gestion des entreprises',
    photoAssetPath: 'assets/images/profile.jpg',
    formations: const [
      FormationItem(
        etablissement: 'C.S SAINT BERTRAND',
        diplome: 'Diplôme  obtenu en commercial et gestion',
        periode: '2022-2023',
        optionDomaine: 'commercial et gestion',
        estExemple: true,
      ),
    ],
    experiences: const [
      ExperienceItem(
        type: 'Stage / Projet / Emploi',
        titre: 'Intitulé du poste, stage ou projet à compléter',
        organisation: 'Organisation / contexte à compléter',
        periode: 'Dates à compléter',
        description:
            'Description des missions, réalisations ou activités à compléter.',
        estExemple: true,
      ),
    ],
    competencesTechniques: const [
      CompetenceTechnique(
        categorie: 'Développement Flutter',
        niveauOuDetails: 'À préciser (ex. Widgets, navigation, UI responsive)',
        estExemple: true,
      ),
      CompetenceTechnique(
        categorie: 'Programmation web',
        niveauOuDetails: 'À préciser (ex. licencie en informatique appliquer a la gestion des entreprises, async/await, modèles)',
        estExemple: true,
      ),
      CompetenceTechnique(
        categorie: 'Développement informatique',
        niveauOuDetails: 'À préciser (ex. Git/GitHub, bases, outils)',
        estExemple: true,
      ),
      CompetenceTechnique(
        categorie: 'Bureautique',
        niveauOuDetails: 'À préciser (ex. Traitement de texte, tableur, présentation)',
        estExemple: true,
      ),
      CompetenceTechnique(
        categorie: 'Developpeur des applications web',
        niveauOuDetails: 'licence',
        estExemple: true,
      ),
    ],
    langues: const [
      CompetenceLinguistique(
        langue: 'Français',
        niveau: 'Bien',
        estExemple: true,
      ),
      CompetenceLinguistique(
        langue: 'Anglais',
        niveau: 'Bien',
        estExemple: true,
      ),
      CompetenceLinguistique(
        langue: 'Francais',
        niveau: 'Bien',
        estExemple: true,
      ),
    ],
    centresInteret: const [
      CentreInteret(libelle: 'Informatique', estExemple: true),
      CentreInteret(libelle: 'Technologies', estExemple: true),
      CentreInteret(libelle: 'Lecture', estExemple: true),
      CentreInteret(libelle: 'Innovation', estExemple: true),
      CentreInteret(libelle: 'Autres loisirs (à compléter)', estExemple: true),
    ],
    contact: const ContactInfo(
      telephone: '+243 000 000 000 (à compléter)',
      email: 'romaniekaumo@21gmail.com',
      adressePhysique: 'ville de goma/quartier mabanga',
      requeteCarte: 'Goma, Nord-Kivu, République démocratique du Congo',
      linkedinUrl: 'https://www.linkedin.com/in/Romaniekaumo',
      githubUrl: 'https://github.com/Romaniekaumo',
      autresReseaux: {
        'Portfolio / Site web (optionnel)': 'https://exemple.com',
      },
      estExemple: true,
    ),
  );

  /// Liste modifiable pour ajouter ou supprimer des membres de la famille.
  static List<MembreFamille> membresFamilleInitial = [
    const MembreFamille(
      id: 'membre_1',
      nomComplet: 'kaumo kipongo didi',
      lienParente: 'Frere',
      photoAssetPath: 'assets/famille/membre_1.jpg',
      profession: 'etudiant',
      age: null,
      // description: 'etudiant en reseaux et telecomunication.',
      estExemple: true,
    ),
    const MembreFamille(
      id: 'membre_2',
      nomComplet: 'Maman FANNY LUSSI',
      lienParente: 'Mére',
      photoAssetPath: 'assets/famille/membre_2.jpg',
      profession: 'commercante',
      age: null,
      // description: 'Petite description à compléter (facultatif).',
      estExemple: true,
    ),
  ];
}