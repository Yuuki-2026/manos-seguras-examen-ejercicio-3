import 'package:flutter/material.dart';
import 'screens/pantalla_bienvenida.dart';
import 'theme/app_theme.dart';
import 'theme/tema_app.dart';
import 'screens/ejercicios/pantalla_ejercicios.dart';
// Para desactivar un ejercicio, comenta su import y toda su entrada Ejercicio(...).
// Si queda uno solo, se abre directamente sin menú ni botón para volver a elegir.
// import 'screens/ejercicios/ejercicio_1_resumen.dart';
// import 'screens/ejercicios/ejercicio_2_panel.dart';
import 'screens/ejercicios/ejercicio_3_perfil.dart';
// import 'screens/ejercicios/ejercicio_4_apariencia.dart';

const ejercicios = <Ejercicio>[
  /*
  Ejercicio(
      titulo: 'Ejercicio 1 — Resumen de oportunidad',
      pantalla: Ejercicio1Resumen()),
  Ejercicio(
      titulo: 'Ejercicio 2 — Cumplimiento por servicio',
      pantalla: Ejercicio2Panel()),
  */
  Ejercicio(
      titulo: 'Ejercicio 3 — Perfil del observador',
      pantalla: Ejercicio3Perfil()),
  /*
  Ejercicio(
      titulo: 'Ejercicio 4 — Configuración y apariencia',
      pantalla: Ejercicio4Apariencia()),
  */
];

/// ManosSeguras — proyecto base integrado de las Guías de Práctica
/// N.° 2, 3 y 4 del curso SIS048 - Desarrollo de Software II (UAC).
///
/// Flujo de navegación:
///   PantallaBienvenida -> PantallaEstablecimiento -> PantallaPersonal
///   -> PantallaOportunidades
///
/// Este archivo es el punto de partida común que todos los equipos
/// reciben ya funcionando antes de la Evaluación de la Unidad I.
///
/// [temaApp] (definido en lib/theme/tema_app.dart) expone el
/// ThemeMode actual (light/dark/system) como un ValueNotifier
/// accesible desde cualquier pantalla, junto con su correspondiente
/// darkTheme (ver lib/theme/app_theme.dart). Esto evita que algún
/// equipo —sin importar qué variante del Anexo 1 le toque por
/// sorteo— necesite convertir la raíz de la app de Stateless a
/// Stateful ni pasar callbacks a través de toda la cadena de
/// navegación durante los 60 minutos de desarrollo.
///
/// Por defecto el modo es ThemeMode.system. Solo el equipo que
/// reciba la Variante D (Configuración y Apariencia) necesita leer
/// y modificar `temaApp.value` desde su pantalla nueva (importando
/// `theme/tema_app.dart`); el resto de equipos puede ignorar por
/// completo esta variable.
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
