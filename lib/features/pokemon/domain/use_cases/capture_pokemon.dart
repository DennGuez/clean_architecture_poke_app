import 'package:clean_architecture_poke_app/core/error/failures.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/repos/pokemons_repo.dart';
import 'package:dartz/dartz.dart';

class CapturePokemonUseCase {
  final PokemonsRepo repo;
  CapturePokemonUseCase({ required this.repo});

  // Al momento instanciar esta classe llama automaticamente el método call()
  Future<Either<Failure, bool>> call(Pokemon  pokemon) async {
    return repo.capturePokemon(pokemon);
  }

}