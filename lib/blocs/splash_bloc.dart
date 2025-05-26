import 'dart:async';
import 'package:bloc/bloc.dart';
import '../logic/pokemon_service_http.dart';
import 'splash_event.dart';
import 'splash_state.dart';

/// BLoC responsable de manejar la lógica de carga y progreso inicial de la app.
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final PokemonService _pokemonService;

  /// Constructor que recibe el servicio de Pokémon e inicializa los manejadores de eventos.
  SplashBloc({required PokemonService pokemonService})
      : _pokemonService = pokemonService,
        super(SplashInitial()) {
    // Registra el manejador para iniciar la carga
    on<SplashLoadPokemons>(_onLoadPokemons);
    // Registra el manejador para actualizar el progreso
    on<SplashUpdateProgress>(_onUpdateProgress);
  }

  /// Manejador del evento SplashLoadPokemons.
  /// Inicia la carga de Pokémon y emite el progreso en tiempo real.
  Future<void> _onLoadPokemons(
      SplashLoadPokemons event, Emitter<SplashState> emit) async {
    emit(const SplashLoading(progress: 0)); // Estado inicial con 0%

    try {
      await _pokemonService.fetchPokemonsWithProgress(
        onProgress: (current, total) {
          // Calcula el porcentaje de progreso
          final percent = ((current / total) * 100).round();
          // Dispara evento para actualizar el progreso
          add(SplashUpdateProgress(percent));
        },
      );

      emit(const SplashLoadSuccess()); // Estado final de éxito
    } catch (e) {
      emit(SplashLoadFailure(e.toString())); // Estado de error con el mensaje
    }
  }

  /// Manejador del evento SplashUpdateProgress.
  /// Actualiza el estado con el nuevo valor de progreso.
  void _onUpdateProgress(
      SplashUpdateProgress event, Emitter<SplashState> emit) {
    emit(SplashLoading(progress: event.progress));
  }
}

