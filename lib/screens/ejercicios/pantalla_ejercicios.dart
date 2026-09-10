import 'package:flutter/material.dart';

// Cada entrada une un título con su pantalla. El catálogo vive en main.dart.
class Ejercicio {
  final String titulo;
  final Widget pantalla;

  const Ejercicio({required this.titulo, required this.pantalla});
}

class PantallaEjercicios extends StatefulWidget {
  final List<Ejercicio> ejercicios;

  const PantallaEjercicios({super.key, required this.ejercicios});

  @override
  State<PantallaEjercicios> createState() => _PantallaEjerciciosState();
}

class _PantallaEjerciciosState extends State<PantallaEjercicios> {
  // null significa que se está mostrando el menú.
  int? _indice;

  void _abrir(int indice) {
    setState(() {
      _indice = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ejercicios = widget.ejercicios;
    // Con una sola entrada abrimos directamente la posición 0, sin menú.
    final indice = ejercicios.length == 1 ? 0 : _indice;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios de práctica'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (indice == null) ...[
                  Text('Pantallas del sorteo',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  const Text('Ejemplos para estudiar con datos simulados.'),
                  const SizedBox(height: 16),
                  if (ejercicios.isEmpty)
                    const Text('No hay ejercicios registrados en main.dart.'),
                  for (int i = 0; i < ejercicios.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        onPressed: () => _abrir(i),
                        child: Text(ejercicios[i].titulo),
                      ),
                    ),
                ] else ...[
                  Text(ejercicios[indice].titulo,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  ejercicios[indice].pantalla,
                  const SizedBox(height: 24),
                  // Se calcula con la lista actual: no depende de otro archivo.
                  if (indice + 1 < ejercicios.length)
                    ElevatedButton.icon(
                      onPressed: () => _abrir(indice + 1),
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Siguiente ejercicio'),
                    ),
                  // Solo tiene sentido volver a elegir si hay varias opciones.
                  if (ejercicios.length > 1) ...[
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _indice = null;
                        });
                      },
                      icon: const Icon(Icons.apps),
                      label: const Text('Volver al menú de ejercicios'),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
