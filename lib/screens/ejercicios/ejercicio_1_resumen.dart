import 'package:flutter/material.dart';

// El modelo queda en este archivo para poder retirar el ejercicio completo.
class OportunidadObservada {
  final String observado;
  final String servicio;
  final List<String> momentos;
  final bool cumplio;
  final String? comentario; // Puede no haberse registrado una observación.

  const OportunidadObservada({
    required this.observado,
    required this.servicio,
    required this.momentos,
    required this.cumplio,
    this.comentario,
  });
}

class Ejercicio1Resumen extends StatelessWidget {
  const Ejercicio1Resumen({super.key});

  @override
  Widget build(BuildContext context) {
    const oportunidad = OportunidadObservada(
      observado: 'Carlos Huamán Ttito',
      servicio: 'Medicina General',
      cumplio: true,
      momentos: [
        '1. Antes de tocar al paciente',
        '2. Antes de una tarea limpia/aséptica',
        '3. Después del riesgo de exposición a fluidos',
        '4. Después de tocar al paciente',
        '5. Después del contacto con el entorno del paciente',
      ],
    );
    final colores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    // MediaQuery mide la pantalla completa, antes del padding del menú.
    final esMobil = MediaQuery.sizeOf(context).width < 600;
    final avatar = _buildAvatar(context, oportunidad.cumplio);
    final datos = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(oportunidad.observado, style: textos.titleLarge),
        const SizedBox(height: 8),
        Text('Servicio: ${oportunidad.servicio}'),
        Text(oportunidad.cumplio ? 'Cumplió' : 'No cumplió'),
        const SizedBox(height: 8),
        Text(oportunidad.comentario ?? 'Sin comentario registrado'),
      ],
    );
    return Container(
      padding: EdgeInsets.all(esMobil ? 16 : 24),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: colores.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // El ancho de pantalla decide si el avatar va arriba o al lado.
          if (esMobil)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [avatar, const SizedBox(height: 16), datos],
            )
          else
            Row(children: [
              avatar,
              const SizedBox(width: 24),
              Expanded(child: datos),
            ]),
          const SizedBox(height: 24),
          Text('Los 5 momentos', style: textos.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final momento in oportunidad.momentos)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colores.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(momento,
                      style: textos.bodyMedium
                          ?.copyWith(color: colores.onSecondaryContainer)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, bool cumplio) {
    final colores = Theme.of(context).colorScheme;
    return SizedBox(
      width: 88,
      height: 88,
      child: Stack(children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: colores.primaryContainer,
            shape: BoxShape.circle,
          ),
          child:
              Icon(Icons.person, size: 48, color: colores.onPrimaryContainer),
        ),
        // La insignia se posiciona dentro de los límites de este Stack.
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: cumplio ? colores.primary : colores.error,
              shape: BoxShape.circle,
            ),
            child: Icon(cumplio ? Icons.check : Icons.close,
                color: cumplio ? colores.onPrimary : colores.onError, size: 20),
          ),
        ),
      ]),
    );
  }
}
