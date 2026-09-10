import 'package:flutter/material.dart';
import '../models/oportunidad.dart';

import '../widgets/app_layout.dart';
import '../widgets/tarjeta_base.dart';
import 'pantalla_establecimiento.dart';

/// Pantalla de bienvenida de ManosSeguras, construida en la Guía de
/// Práctica N.° 2 (Sesiones 4-5) aplicando los widgets básicos
/// (Text, Container, Icon) y las técnicas de espaciado (padding,
/// margin) y anidamiento de widgets.
///
/// Incluye la tarjeta "Los 5 Momentos", que presenta el catálogo
/// oficial de la OMS/MINSA como introducción antes de auditar
/// cualquier establecimiento.
class PantallaBienvenida extends StatelessWidget {
  final Widget? menuEjercicios;

  const PantallaBienvenida({super.key, this.menuEjercicios});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ManosSeguras')),
      body: SingleChildScrollView(
        child: AppLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Encabezado(),
              if (menuEjercicios != null) ...[
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Igual que el flujo base: una navegación simple al menú.
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => menuEjercicios!,
                    ));
                  },
                  icon: const Icon(Icons.school_outlined),
                  label: const Text('Abrir ejercicios de práctica'),
                ),
              ],
              const SizedBox(height: 24),
              _TarjetaCincoMomentos(),
              const SizedBox(height: 24),
              _BotonComenzar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.clean_hands,
              color: Theme.of(context).colorScheme.onPrimary, size: 40),
          const SizedBox(height: 12),
          Text(
            'ManosSeguras',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Auditoría digital de higiene de manos, alineada a la '
            'RM N.° 255-2016/MINSA y al ODS 3 (Salud y bienestar).',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _TarjetaCincoMomentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TarjetaBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.checklist_rtl,
                  color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Los 5 Momentos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Instrumento oficial de la OMS para la higiene de manos '
            'en establecimientos de salud.',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 13),
          ),
          const SizedBox(height: 16),
          ...Momento.values.map(
            (m) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${m.index + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      m.etiqueta,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BotonComenzar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const PantallaEstablecimiento(),
            ),
          );
        },
        icon: const Icon(Icons.arrow_forward),
        label: const Text('Comenzar auditoría'),
      ),
    );
  }
}
