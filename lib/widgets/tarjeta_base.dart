import 'package:flutter/material.dart';

/// Tarjeta base con estilo institucional, construida en la Guía de
/// Práctica N.° 2 (Sesiones 4-5: Container, padding, margin) y
/// reutilizada desde entonces en el resto de pantallas del proyecto,
/// tal como se indica en la Tabla 2 de la ficha de evaluación
/// ("estilo visual base de tarjetas").
class TarjetaBase extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const TarjetaBase({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.only(bottom: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: child,
    );
  }
}
