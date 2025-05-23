import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para iniciar la carga de pokemons (disparado al llegar a la pantalla de loader).
class SplashLoadPokemons extends SplashEvent {}

