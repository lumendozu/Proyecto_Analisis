import 'package:equatable/equatable.dart';

/// Clase base abstracta para todos los estados del SplashBloc.
/// Equatable permite comparar instancias por valor (útil para test y render optimizado).
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial antes de que comience la carga de datos.
class SplashInitial extends SplashState {}

/// Estado de carga en progreso.
/// Incluye un valor entero que representa el porcentaje actual (0 a 100).
class SplashLoading extends SplashState {
  final int progress;

  const SplashLoading({this.progress = 0});

  @override
  List<Object?> get props => [progress];
}

/// Estado emitido cuando la carga de Pokémon fue exitosa.
class SplashLoadSuccess extends SplashState {
  const SplashLoadSuccess();
}

/// Estado emitido cuando ocurre un error al intentar cargar los datos.
/// Incluye un mensaje de error para mostrar o registrar.
class SplashLoadFailure extends SplashState {
  final String mensajeError;

  const SplashLoadFailure(this.mensajeError);

  @override
  List<Object?> get props => [mensajeError];
}

