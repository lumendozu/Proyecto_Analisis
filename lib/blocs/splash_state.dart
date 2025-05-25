import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial, antes de que comience la carga.
class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {
  final int progress; // de 0 a 100
  const SplashLoading({this.progress = 0});
  @override
  List<Object?> get props => [progress];
}


/// Se cargó exitosamente la lista de pokémons.
class SplashLoadSuccess extends SplashState {
  const SplashLoadSuccess();
}

/// Ocurrió un error al cargar los pokémons.
class SplashLoadFailure extends SplashState {
  final String mensajeError;

  const SplashLoadFailure(this.mensajeError);

  @override
  List<Object?> get props => [mensajeError];
}

