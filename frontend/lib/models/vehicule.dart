// lib/models/vehicule.dart
class Proprietaire {
  final String nom;
  final String prenom;
  final String telephone;
  final String adresse;
  final String photo;

  Proprietaire({
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.adresse,
    required this.photo,
  });

  factory Proprietaire.fromJson(Map<String, dynamic> json) {
    return Proprietaire(
      nom: json['nom'],
      prenom: json['prenom'],
      telephone: json['telephone'],
      adresse: json['adresse'],
      photo: json['photo'],
    );
  }
}

class Vehicule {
  final String plaque;
  final String marque;
  final String modele;
  final String photo;
  final DateTime dateFinAssurance;
  final DateTime dateControleTechnique;
  final int poids;
  final DateTime dateMiseCirculation;
  final String typeMoteur;
  final String puissance;
  final String transmission;
  final String consommation;
  final Proprietaire proprietaire;

  Vehicule({
    required this.plaque,
    required this.marque,
    required this.modele,
    required this.photo,
    required this.dateFinAssurance,
    required this.dateControleTechnique,
    required this.poids,
    required this.dateMiseCirculation,
    required this.typeMoteur,
    required this.puissance,
    required this.transmission,
    required this.consommation,
    required this.proprietaire,
  });

  factory Vehicule.fromJson(Map<String, dynamic> json) {
    return Vehicule(
      plaque: json['plaque'],
      marque: json['marque'],
      modele: json['modele'],
      photo: json['photo'],
      dateFinAssurance: DateTime.parse(json['date_fin_assurance']),
      dateControleTechnique: DateTime.parse(json['date_controle_technique']),
      poids: json['poids'],
      dateMiseCirculation: DateTime.parse(json['date_mise_circulation']),
      typeMoteur: json['type_moteur'],
      puissance: json['puissance'],
      transmission: json['transmission'],
      consommation: json['consommation'],
      proprietaire: Proprietaire.fromJson(json['proprietaire']),
    );
  }
}