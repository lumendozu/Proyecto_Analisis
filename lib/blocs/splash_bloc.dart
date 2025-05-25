import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../logic/pokemon_service_http.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final PokemonService _pokemonService;

  SplashBloc({required PokemonService pokemonService})
      : _pokemonService = pokemonService,
        super(SplashInitial()) {
    on<SplashLoadPokemons>(_onLoadPokemons);
    on<SplashUpdateProgress>(_onUpdateProgress);
  }

  Future<void> _onLoadPokemons(
      SplashLoadPokemons event, Emitter<SplashState> emit) async {
    emit(const SplashLoading(progress: 0));

    try {
      final data = await _pokemonService.fetchPokemonsWithProgress(
        onProgress: (current, total) {
          final percent = ((current / total) * 100).round();
          add(SplashUpdateProgress(percent));
        },
      );

      emit(const SplashLoadSuccess());
    } catch (e) {
      emit(SplashLoadFailure(e.toString()));
    }
  }

  void _onUpdateProgress(
      SplashUpdateProgress event, Emitter<SplashState> emit) {
    emit(SplashLoading(progress: event.progress));
  }
}

