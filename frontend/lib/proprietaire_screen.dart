import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'models/vehicule.dart';
import 'services/vehicule_service.dart';
import 'routes/app_routes.dart';

class ProprietaireScreen extends StatefulWidget {
  final String plaque;

  const ProprietaireScreen({Key? key, required this.plaque}) : super(key: key);

  @override
  State<ProprietaireScreen> createState() => _ProprietaireScreenState();
}

class _ProprietaireScreenState extends State<ProprietaireScreen> {
  final VehiculeService _vehiculeService = VehiculeService();
  late Future<Vehicule> _vehiculeFuture;

  @override
  void initState() {
    super.initState();
    _vehiculeFuture = _vehiculeService.getVehiculeByPlaque(widget.plaque);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Vehicule>(
      future: _vehiculeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Erreur: ${snapshot.error}')),
          );
        }

        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('Aucune donnée trouvée')),
          );
        }

        final vehicule = snapshot.data!;

        return _buildContent(vehicule);
      },
    );
  }

  Widget _buildContent(Vehicule vehicule) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0XFF0A345A),
              const Color(0XFF0A345A).withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildVehiculeSection(vehicule),
                        SizedBox(height: 20.h),
                        _buildProprietaireSection(vehicule.proprietaire),
                        SizedBox(height: 20.h),
                        _buildDetailsSection(vehicule),
                        SizedBox(height: 20.h),
                        _buildAmendeButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.r),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Informations générales\ndu véhicule',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 40.w),
        ],
      ),
    );
  }

  Widget _buildVehiculeSection(Vehicule vehicule) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plaque d\'immatriculation : ${vehicule.plaque}',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0XFF0A345A),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Marque : ${vehicule.marque}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0XFF0A345A),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Modèle : ${vehicule.modele}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0XFF0A345A),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                'http://10.0.2.2:8000/static/${vehicule.photo}',
                width: 150.w,
                height: 84.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 150.w,
                    height: 84.h,
                    color: Colors.grey,
                    child: const Icon(Icons.error),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProprietaireSection(Proprietaire proprietaire) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0XFF0A345A).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Propriétaire',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Nom : ${proprietaire.nom}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Prénom : ${proprietaire.prenom}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 50.r,
                backgroundImage: NetworkImage(
                  'http://10.0.2.2:8000/static/${proprietaire.photo}',
                ),
                onBackgroundImageError: (exception, stackTrace) {
                  // Gestion de l'erreur de chargement de l'image
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Téléphone : ${proprietaire.telephone}',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Adresse : ${proprietaire.adresse}',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(Vehicule vehicule) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0XFF0A345A).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Date de fin de l\'assurance :',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            dateFormat.format(vehicule.dateFinAssurance),
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: 180.w,
            height: 2,
            color: const Color(0XFF0A345A).withOpacity(0.5),
          ),
          SizedBox(height: 12.h),
          Text(
            'Date du dernier contrôle technique :',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            dateFormat.format(vehicule.dateControleTechnique),
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 8.w),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.infosTechniquesVehiculeScreen,
                      arguments: vehicule.plaque,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF53687D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    elevation: 0,
                  ),
                  child: Text(
                    'voir plus >>',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmendeButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Center(
        child: SizedBox(
          width: 200.w,
          height: 40.h,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFFBE0F0F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Text(
              'Emettre une amende',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}