import 'package:flutter/material.dart';
import '../../models/personal.dart';

class Ejercicio3Perfil extends StatelessWidget {
  const Ejercicio3Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    const observador = Observador(
      dni: '23456789',
      nombresApellidos: 'Ana Quispe Mamani',
      turnoActivo: true,
      turno: 'Mañana',
      upss: ['Medicina General', 'Emergencia', 'Hospitalización'],
    );
    final colores = Theme.of(context).colorScheme;

    // MediaQuery mide la pantalla completa, antes del padding del menú.
    final esMobil = MediaQuery.sizeOf(context).width < 600;
    final avatar = _buildAvatar(context, observador.turnoActivo);
    final datos = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(observador.nombresApellidos,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        _buildDato(context, Icons.badge, 'DNI: ${observador.dni}'),
        _buildDato(context, Icons.schedule, 'Turno: ${observador.turno}'),
        _buildDato(context, Icons.mail_outline,
            observador.correo ?? 'Correo no registrado'),
        _buildDato(context, Icons.info_outline,
            observador.turnoActivo ? 'Turno activo' : 'Fuera de turno'),
      ],
    );
    return Container(
      padding: EdgeInsets.all(esMobil ? 16 : 24),
      decoration: BoxDecoration(
        color: colores.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (esMobil)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [avatar, const SizedBox(height: 16), datos],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatar,
                const SizedBox(width: 24),
                Expanded(child: datos)
              ],
            ),
          const SizedBox(height: 24),
          Text('UPSS asignadas',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final upss in observador.upss)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colores.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(upss,
                    style: TextStyle(color: colores.onSecondaryContainer)),
              ),
          ]),
        ],
      ),
    );
  }

  Widget _buildDato(BuildContext context, IconData icono, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          // Flexible permite que el texto largo salte de línea sin overflow.
          Flexible(child: Text(texto)),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, bool activo) {
    final colores = Theme.of(context).colorScheme;
    return SizedBox(
      width: 104,
      height: 104,
      child: Stack(children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: colores.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.person_outline,
              size: 56, color: colores.onPrimaryContainer),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: activo ? colores.primary : colores.secondary,
              shape: BoxShape.circle,
            ),
            child: Icon(activo ? Icons.check : Icons.schedule,
                size: 20,
                color: activo ? colores.onPrimary : colores.onSecondary),
          ),
        ),
      ]),
    );
  }
}
