import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'proprietaire_screen.dart';
import 'infos_techniques_vehicule_screen.dart';
import 'routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Fixer l'orientation en mode portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Dimensions de base du design
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gestion Carte Grise',

          // Configuration du thème
          theme: ThemeData(
            primaryColor: const Color(0XFF0A345A),
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Inter',
            useMaterial3: true,
          ),

          // Support de la localisation
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // Langues prises en charge
          supportedLocales: const [
            Locale('fr'), // Français
            Locale('en'), // Anglais
          ],

          // Langue par défaut
          locale: const Locale('fr'),

          // Configuration des routes
          initialRoute: AppRoutes.proprietaireScreen,
          onGenerateRoute: (settings) {
            if (settings.name == AppRoutes.proprietaireScreen) {
              return MaterialPageRoute(
                builder: (context) => ProprietaireScreen(plaque: 'DK-1234-AA'),
              );
            }
            if (settings.name == AppRoutes.infosTechniquesVehiculeScreen) {
              final plaque = settings.arguments as String;
              return MaterialPageRoute(
                builder: (context) => InfosTechniquesVehiculeScreen(plaque: plaque),
              );
            }
            return null;
          },
        );
      },
    );
  }
}