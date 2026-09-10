import 'package:flutter/material.dart';

class IndicadorMomento {
  final String nombre;
  final int cumplidas;
  final int total;
  final String? nota;

  const IndicadorMomento({
    required this.nombre,
    required this.cumplidas,
    required this.total,
    this.nota,
  });

  // Evita dividir entre cero cuando no hay observaciones.
  double get porcentaje => total == 0 ? 0 : cumplidas * 100 / total;
}

class Ejercicio2Panel extends StatelessWidget {
  const Ejercicio2Panel({super.key});

  @override
  Widget build(BuildContext context) {
    const indicadores = [
      IndicadorMomento(
          nombre: '1. Antes de tocar al paciente', cumplidas: 8, total: 10),
      IndicadorMomento(
          nombre: '2. Antes de una tarea limpia/aséptica',
          cumplidas: 9,
          total: 10),
      IndicadorMomento(
          nombre: '3. Después del riesgo de fluidos', cumplidas: 7, total: 10),
      IndicadorMomento(
          nombre: '4. Después de tocar al paciente', cumplidas: 10, total: 10),
      IndicadorMomento(
          nombre: '5. Después del contacto con el entorno',
          cumplidas: 0,
          total: 0,
          nota: 'Pendiente de observación'),
    ];

    // MediaQuery mide la pantalla completa, antes del padding del menú.
    final esMobil = MediaQuery.sizeOf(context).width < 600;
    final resumen = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.local_hospital,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
          const SizedBox(height: 12),
          Text('Medicina General',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer)),
          const SizedBox(height: 8),
          Text('Cumplimiento por momento\nDatos simulados',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer)),
        ],
      ),
    );
    final barras = Column(children: [
      for (final indicador in indicadores) _buildIndicador(context, indicador),
    ]);
    // Abstract: dos bloques; Measure: ancho; Branch: columna o fila.
    if (esMobil) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [resumen, const SizedBox(height: 16), barras],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: resumen),
        const SizedBox(width: 24),
        Expanded(flex: 2, child: barras),
      ],
    );
  }

  Widget _buildIndicador(BuildContext context, IndicadorMomento indicador) {
    final colores = Theme.of(context).colorScheme;
    final porcentaje = indicador.porcentaje.round();
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colores.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(child: Text(indicador.nombre)),
            const SizedBox(width: 8),
            Flexible(
                child:
                    Text(indicador.total == 0 ? 'Sin datos' : '$porcentaje%')),
          ]),
          const SizedBox(height: 12),
          SizedBox(
            height: 14,
            child: Row(children: [
              // No creamos Expanded con flex 0 en los extremos 0% y 100%.
              if (porcentaje > 0)
                Expanded(
                    flex: porcentaje, child: Container(color: colores.primary)),
              if (porcentaje < 100)
                Expanded(
                    flex: 100 - porcentaje,
                    child: Container(color: colores.outlineVariant)),
            ]),
          ),
          const SizedBox(height: 8),
          Text('${indicador.cumplidas} de ${indicador.total} oportunidades'),
          if (indicador.nota != null) Text(indicador.nota ?? ''),
        ],
      ),
    );
  }
}
