import 'package:clean_architecture_poke_app/core/error/failures.dart';
import 'package:clean_architecture_poke_app/core/utils/utils.dart' as utils;
import 'package:clean_architecture_poke_app/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/use_cases/capture_pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/use_cases/get_caputed_pokemons.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/use_cases/get_pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_pokemon_event.dart';
part 'search_pokemon_state.dart';

class SearchPokemonBloc extends Bloc<SearchPokemonEvent, SearchPokemonState> {

  // Inicializamos los use cases
  final CapturePokemonUseCase _capturePokemonUseCase;
  final GetCapturedPokemonsUseCase _getCapturedPokemonsUseCase;
  final GetPokemonUseCase _getPokemonUseCase;

  SearchPokemonBloc(this._capturePokemonUseCase,
      this._getCapturedPokemonsUseCase, this._getPokemonUseCase)
      : super(SearchPokemonInitial()) {
        
    // Eventos de Bloc (Tenemos tres eventos)
    on<OnSearchPokemon>((event, emit) async {
      emit(SearchPokemonLoading());

      final resp = await _getPokemonUseCase(utils.randomPokemonId);
      // Dartz: la resp devuelve un Either<Failure, Pokemon>
      // Ese tipo de dato se resuelve de la siguiente manera:
      // resp.fold((left) => null, (right) => null );
      resp.fold((f) => emit(SearchPokemonFailure(failure:  f)),
          (p) => emit(SearchPokemonSuccess(pokemon: p)));
    });

    on<OnCapturePokemon>((event, emit) async {
      final resp = await _capturePokemonUseCase(event.pokemon);

      resp.fold((f) => emit(SearchPokemonFailure(failure: f)), (p) {});
    });

    on<OnGetCapturedPokemons>((event, emit) async {
      final resp = await _getCapturedPokemonsUseCase();

      resp.fold((f) => emit(SearchPokemonFailure(failure: f)),
          (ps) => emit(SearchPokemonList(pokemons: ps)));
    });
  }
}
