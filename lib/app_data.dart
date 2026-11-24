
import 'models/cv_model.dart';

/// Données centralisées de l'application.
class AppData {
  AppData._();

  static const String appName = 'Mon CV Personnel';
  static const String repoName = 'cv_flutter_kaumo_kipongo_romanie';

  static const String githubRepoUrl =
      'https://github.com/TON_USERNAME/cv_flutter_kaumo_kipongo_romanie';

  static final CvProfile profilCv = CvProfile(
    nomComplet: 'KAUMO KIPONGO ROMANIE',
    titreProfessionnel: 'Développeur Flutter',
    presentationCourte:
        'Etudiante en licence informatique appliquée à la gestion des entreprises',
    photoAssetPath: 'assets/images/profile.jpg',

    formations: const [
      FormationItem(
        etablissement: 'C.S SAINT BERTRAND',
        diplome: 'Diplôme obtenu en commercial et gestion',
        periode: '2022-2023',
        optionDomaine: 'Commercial et gestion',
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
        niveauOuDetails:
            'À préciser (ex. Widgets, navigation, UI responsive)',
        estExemple: true,
      ),
      CompetenceTechnique(
        categorie: 'Programmation web',
        niveauOuDetails:
            'Licence en informatique appliquée à la gestion des entreprises',
        estExemple: true,
      ),
      CompetenceTechnique(
        categorie: 'Développement informatique',
        niveauOuDetails: 'Git/GitHub, bases de données et outils',
        estExemple: true,
      ),
      CompetenceTechnique(
        categorie: 'Bureautique',
        niveauOuDetails: 'Traitement de texte, tableur, présentation',
        estExemple: true,
      ),
      CompetenceTechnique(
        categorie: 'Développeur des applications web',
        niveauOuDetails: 'Licence',
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
    ],

    centresInteret: const [
      CentreInteret(libelle: 'Informatique', estExemple: true),
      CentreInteret(libelle: 'Technologies', estExemple: true),
      CentreInteret(libelle: 'Lecture', estExemple: true),
      CentreInteret(libelle: 'Innovation', estExemple: true),
      CentreInteret(
        libelle: 'Autres loisirs (à compléter)',
        estExemple: true,
      ),
    ],

    contact: const ContactInfo(
      telephone: '+243 000 000 000 (à compléter)',
      email: 'romaniekaumo@21gmail.com',
      adressePhysique: 'Ville de Goma, quartier Mabanga',
      requeteCarte:
          'Goma, Nord-Kivu, République démocratique du Congo',
      linkedinUrl: 'https://www.linkedin.com/in/Romaniekaumo',
      githubUrl: 'https://github.com/Romaniekaumo',
      autresReseaux: {
        'Portfolio / Site web (optionnel)': 'https://exemple.com',
      },
      estExemple: true,
    ),
  );
}
