import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manos_seguras/main.dart';
import 'package:manos_seguras/screens/ejercicios/pantalla_ejercicios.dart';
import 'package:manos_seguras/theme/app_theme.dart';
import 'package:manos_seguras/theme/tema_app.dart';

void main() {
  tearDown(() => temaApp.value = ThemeMode.system);

  for (final ancho in [320.0, 600.0, 839.0, 1024.0]) {
    for (final modo in [ThemeMode.light, ThemeMode.dark]) {
      testWidgets('Cuatro pantallas sin overflow: ancho $ancho, $modo',
          (tester) async {
        tester.view.physicalSize = Size(ancho, 900);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        for (final ejercicio in ejercicios) {
          await tester.pumpWidget(MaterialApp(
            theme: AppTheme.theme,
            darkTheme: AppTheme.darkTheme,
            themeMode: modo,
            home: PantallaEjercicios(ejercicios: [ejercicio]),
          ));
          await tester.pumpAndSettle();
          expect(find.text(ejercicio.titulo), findsOneWidget);
          expect(find.text('Pantallas del sorteo'), findsNothing);
          expect(find.text('Siguiente ejercicio'), findsNothing);
          expect(find.text('Volver al menú de ejercicios'), findsNothing);
          expect(find.byType(ejercicio.pantalla.runtimeType), findsOneWidget);
          expect(tester.takeException(), isNull);
          await tester.pumpWidget(const SizedBox());
        }
      });
    }
  }

  testWidgets(
      'Navegación funciona al retirar cualquiera de las cuatro entradas',
      (tester) async {
    for (int retirado = 0; retirado < ejercicios.length; retirado++) {
      final restantes = [...ejercicios]..removeAt(retirado);
      if (restantes.isEmpty) continue;
      await tester.pumpWidget(MaterialApp(
        home: PantallaEjercicios(ejercicios: restantes),
      ));
      if (restantes.length > 1) {
        await tester.tap(find.text(restantes.first.titulo));
      }
      await tester.pumpAndSettle();
      for (int i = 1; i < restantes.length; i++) {
        final siguiente = find.text('Siguiente ejercicio');
        await tester.ensureVisible(siguiente);
        await tester.tap(siguiente);
        await tester.pumpAndSettle();
        expect(find.text(restantes[i].titulo), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
      expect(find.text('Siguiente ejercicio'), findsNothing);
      if (restantes.length > 1) {
        await tester.ensureVisible(find.text('Volver al menú de ejercicios'));
        await tester.tap(find.text('Volver al menú de ejercicios'));
        await tester.pumpAndSettle();
        expect(find.text('Pantallas del sorteo'), findsOneWidget);
      } else {
        expect(find.text('Volver al menú de ejercicios'), findsNothing);
      }
      await tester.pumpWidget(const SizedBox());
    }
  });

  testWidgets('Catálogo vacío muestra un mensaje', (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: PantallaEjercicios(ejercicios: [])));
    expect(find.text('No hay ejercicios registrados en main.dart.'),
        findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Acceso desde bienvenida y selección claro, oscuro, sistema',
      (tester) async {
    final apariencia =
        ejercicios.where((e) => e.titulo.contains('Ejercicio 4')).toList();
    if (apariencia.isEmpty) {
      return; // Se puede borrar el ejercicio 4 sin editar este test.
    }
    await tester.pumpWidget(const ManosSegurasApp());
    await tester.tap(find.text('Abrir ejercicios de práctica'));
    await tester.pumpAndSettle();
    if (ejercicios.length > 1) {
      await tester.tap(find.text(apariencia.first.titulo));
    }
    await tester.pumpAndSettle();
    for (final opcion in ['Claro', 'Oscuro', 'Sistema']) {
      await tester.tap(find.widgetWithText(ElevatedButton, opcion));
      await tester.pumpAndSettle();
      expect(find.text('Selección: $opcion'), findsOneWidget);
      final contexto = tester.element(find.text('Vista previa'));
      expect(Theme.of(contexto).brightness,
          opcion == 'Oscuro' ? Brightness.dark : Brightness.light);
      expect(tester.takeException(), isNull);
    }
  });
}
