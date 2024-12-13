// lib/services/vehicule_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vehicule.dart';

class VehiculeService {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // URL pour l'émulateur Android

  Future<Vehicule> getVehiculeByPlaque(String plaque) async {
    final response = await http.get(Uri.parse('$baseUrl/vehicule/$plaque/'));

    if (response.statusCode == 200) {
      return Vehicule.fromJson(json.decode(response.body));
    } else {
      throw Exception('Échec du chargement du véhicule');
    }
  }
}