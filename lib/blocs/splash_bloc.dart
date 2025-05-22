import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../logic/pokemon_service_http.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final PokemonService _pokemonService;

  SplashBloc({required PokemonService pokemonService})
      : _pokemonService = pokemonService,
        super(SplashInitial()) {
    on<SplashLoadPokemons>(_onLoadPokemons);
  }

  Future<void> _onLoadPokemons(
      SplashLoadPokemons event, Emitter<SplashState> emit) async {
    emit(SplashLoading());

    try {

      // Intentar la llamada real al servicio:
      final data = await _pokemonService.fetchPokemons();

      // Si no lanza excepción, emitimos éxito:
      emit(const SplashLoadSuccess());
    } catch (e) {
      // Si algo falla, emitimos estado de error con el mensaje:
      emit(SplashLoadFailure(e.toString()));
    }
  }
}

