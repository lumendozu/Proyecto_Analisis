import 'package:equatable/equatable.dart';

/// Clase base abstracta para todos los eventos del SplashBloc.
/// Usa Equatable para facilitar la comparación entre instancias.
abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

/// Evento que se dispara para iniciar la carga de Pokémon.
/// Generalmente se lanza al entrar a la pantalla de carga (splash).
class SplashLoadPokemons extends SplashEvent {}

/// Evento que actualiza el porcentaje de progreso durante la carga.
/// Se dispara múltiples veces a medida que se cargan los datos.
class SplashUpdateProgress extends SplashEvent {
  final int progress; // Progreso actual (0 a 100)

  const SplashUpdateProgress(this.progress);

  @override
  List<Object?> get props => [progress];
}

