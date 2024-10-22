import 'package:clean_architecture_poke_app/core/error/failures.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/repos/pokemons_repo.dart';
import 'package:dartz/dartz.dart';

class GetPokemonUseCase {
  final PokemonsRepo repo;
  GetPokemonUseCase({ required this.repo});

  // Al momento instanciar esta classe llama automaticamente el método call()
  Future<Either<Failure, Pokemon>> call(int id) async {
    return repo.getPokemon(id);
  }

}