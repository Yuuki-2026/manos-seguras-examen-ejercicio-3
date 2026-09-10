import 'package:flutter/material.dart';

/// Avatar circular con un indicador de estado superpuesto en la
/// esquina inferior derecha, construido con Stack y Positioned
/// (Guía de Práctica N.° 4, Sesión 8).
///
/// Se usa tanto para mostrar el estado de cumplimiento de una
/// oportunidad de observación (check = cumplió, cruz = omisión)
/// como para representar el avatar del personal observado.
class IndicadorEstado extends StatelessWidget {
  final String iniciales;
  final bool cumplio;
  final double radio;

  const IndicadorEstado({
    super.key,
    required this.iniciales,
    required this.cumplio,
    this.radio = 28,
  });

  @override
  Widget build(BuildContext context) {
    final colorEstado = cumplio
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.error;
    final diametroBadge = radio * 0.65;

    return SizedBox(
      width: radio * 2 + 6,
      height: radio * 2 + 6,
      child: Stack(
        // clipBehavior en none: el badge sobresale ligeramente fuera
        // del círculo del avatar, como se explicó en la Sesión 8
        // (2.5. clipBehavior: qué ocurre con el contenido desbordado).
        clipBehavior: Clip.none,
        children: [
          // Widget no posicionado: ocupa la posición natural dentro
          // del Stack (esquina superior izquierda del área disponible).
          CircleAvatar(
            radius: radio,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              iniciales,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Widget posicionado con precisión mediante Positioned,
          // ubicado en la esquina inferior derecha del avatar.
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: diametroBadge,
              height: diametroBadge,
              decoration: BoxDecoration(
                color: colorEstado,
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary, width: 2),
              ),
              child: Icon(
                cumplio ? Icons.check : Icons.close,
                size: diametroBadge * 0.65,
                color: cumplio
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
