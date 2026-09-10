import 'package:flutter/material.dart';
import '../../theme/tema_app.dart';

class Ejercicio4Apariencia extends StatefulWidget {
  const Ejercicio4Apariencia({super.key});

  @override
  State<Ejercicio4Apariencia> createState() => _Ejercicio4AparienciaState();
}

class _Ejercicio4AparienciaState extends State<Ejercicio4Apariencia> {
  void _cambiarTema(ThemeMode modo) {
    // main.dart ya escucha este ValueNotifier y reconstruye el tema global.
    setState(() {
      temaApp.value = modo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    // MediaQuery mide la pantalla completa, antes del padding del menú.
    final esMobil = MediaQuery.sizeOf(context).width < 600;
    final controles = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Elige la apariencia', style: textos.titleLarge),
        const SizedBox(height: 8),
        const Text('El cambio se aplica a toda la aplicación.'),
        const SizedBox(height: 16),
        // Los accesos saltan de línea cuando no queda espacio horizontal.
        Wrap(spacing: 8, runSpacing: 8, children: [
          _buildAcceso(context, 'Claro', Icons.light_mode, ThemeMode.light),
          _buildAcceso(context, 'Oscuro', Icons.dark_mode, ThemeMode.dark),
          _buildAcceso(
              context, 'Sistema', Icons.settings_brightness, ThemeMode.system),
        ]),
        const SizedBox(height: 16),
        Text('Selección: ${_nombreModo(temaApp.value)}'),
        const Text('Sistema utiliza la preferencia del dispositivo.'),
      ],
    );
    final vistaPrevia = Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: colores.surfaceContainerHighest,
        border: Border.all(color: colores.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.clean_hands, color: colores.primary),
            const SizedBox(width: 12),
            Flexible(child: Text('Vista previa', style: textos.titleLarge)),
          ]),
          const SizedBox(height: 16),
          Text('ManosSeguras', style: textos.titleMedium),
          const SizedBox(height: 8),
          Text('Así se verán las tarjetas, los textos y los iconos.',
              style: textos.bodyMedium?.copyWith(color: colores.onSurface)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colores.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('Observación registrada · Ejemplo',
                style: TextStyle(color: colores.onPrimaryContainer)),
          ),
        ],
      ),
    );
    if (esMobil) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [controles, const SizedBox(height: 16), vistaPrevia],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: controles),
        const SizedBox(width: 24),
        Expanded(child: vistaPrevia),
      ],
    );
  }

  Widget _buildAcceso(
      BuildContext context, String titulo, IconData icono, ThemeMode modo) {
    final seleccionado = temaApp.value == modo;
    return ElevatedButton.icon(
      onPressed: () => _cambiarTema(modo),
      icon: Icon(seleccionado ? Icons.check : icono),
      label: Text(titulo),
    );
  }

  String _nombreModo(ThemeMode modo) {
    if (modo == ThemeMode.light) return 'Claro';
    if (modo == ThemeMode.dark) return 'Oscuro';
    return 'Sistema';
  }
}
