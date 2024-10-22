part of 'search_pokemon_bloc.dart';

sealed class SearchPokemonEvent {}

// 1 evento cuando se busque un pokemon
class OnSearchPokemon extends SearchPokemonEvent {}

// 2 evento cuando se capture (guardar en local)
class OnCapturePokemon extends SearchPokemonEvent {
  final Pokemon pokemon;

  OnCapturePokemon({required this.pokemon});
}

// 3 evento cuando se piden los pokemons guardados localmente
class OnGetCapturedPokemons extends SearchPokemonEvent {
  OnGetCapturedPokemons();
}
