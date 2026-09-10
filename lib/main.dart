import 'package:flutter/material.dart';
import 'screens/pantalla_bienvenida.dart';
import 'theme/app_theme.dart';
import 'theme/tema_app.dart';
import 'screens/ejercicios/pantalla_ejercicios.dart';

import 'screens/ejercicios/ejercicio_3_perfil.dart';

const ejercicios = <Ejercicio>[

  Ejercicio(
      titulo: 'Ejercicio 3 — Perfil del observador',
      pantalla: Ejercicio3Perfil()),

];

void main() {
  runApp(const ManosSegurasApp());
}

class ManosSegurasApp extends StatelessWidget {
  const ManosSegurasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: temaApp,
      builder: (context, modoActual, _) {
        return MaterialApp(
          title: 'ManosSeguras',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          darkTheme: AppTheme.darkTheme,
          themeMode: modoActual,
          home: const PantallaBienvenida(
            menuEjercicios: PantallaEjercicios(ejercicios: ejercicios),
          ),
        );
      },
    );
  }
}
