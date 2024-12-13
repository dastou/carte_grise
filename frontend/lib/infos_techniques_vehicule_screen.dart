import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'models/vehicule.dart';
import 'services/vehicule_service.dart';

class InfosTechniquesVehiculeScreen extends StatefulWidget {
  final String plaque;

  const InfosTechniquesVehiculeScreen({Key? key, required this.plaque}) : super(key: key);

  @override
  State<InfosTechniquesVehiculeScreen> createState() => _InfosTechniquesVehiculeScreenState();
}

class _InfosTechniquesVehiculeScreenState extends State<InfosTechniquesVehiculeScreen> {
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
                        _buildTechnicalDetails(vehicule),
                        SizedBox(height: 54.h),
                        Center(
                          child: Text(
                            'Autres détails techniques',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0XFF0A345A),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Center(
                          child: Container(
                            width: 180.w,
                            height: 2,
                            color: const Color(0XFF0A345A),
                          ),
                        ),
                        SizedBox(height: 26.h),
                        _buildAdditionalTechnicalDetails(vehicule),
                        SizedBox(height: 42.h),
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
              'Informations techniques\ndu véhicule',
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

  Widget _buildTechnicalDetails(Vehicule vehicule) {
    final dateFormat = DateFormat('dd MMMM yyyy', 'fr_FR');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0XFF0A345A).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Poids du véhicule :',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${vehicule.poids} kg',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: 180.w,
            height: 2,
            color: Colors.white.withOpacity(0.5),
          ),
          SizedBox(height: 4.h),
          Text(
            'Date de première mise en circulation :',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          Text(
            dateFormat.format(vehicule.dateMiseCirculation),
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: 180.w,
            height: 2,
            color: Colors.white.withOpacity(0.5),
          ),
          SizedBox(height: 6.h),
          Text(
            'Type de moteur :',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          Text(
            vehicule.typeMoteur,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalTechnicalDetails(Vehicule vehicule) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0XFF0A345A),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Puissance', vehicule.puissance),
          SizedBox(height: 34.h),
          _buildDetailRow('Transmission', vehicule.transmission),
          SizedBox(height: 34.h),
          _buildDetailRow('Consommation', vehicule.consommation),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18.sp,
              color: const Color(0XFF0A345A),
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              color: const Color(0XFF0A345A),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmendeButton() {
    return Center(
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
    );
  }
}