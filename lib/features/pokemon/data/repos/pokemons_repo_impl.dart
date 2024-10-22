import 'package:clean_architecture_poke_app/core/error/failures.dart';
import 'package:clean_architecture_poke_app/features/pokemon/data/datasources/pokemons_local_data_source.dart';
import 'package:clean_architecture_poke_app/features/pokemon/data/datasources/pokemons_remote_data_sources.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/repos/pokemons_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PokemonsRepoImpl implements PokemonsRepo {

  final PokemonsLocalDataSource pokemonsLocalDataSource;
  final PokemonsRemoteDataSource pokemonsRemoteDataSource;

  PokemonsRepoImpl({
    required this.pokemonsLocalDataSource, 
    required this.pokemonsRemoteDataSource
  });

  @override
  Future<Either<Failure, bool>> capturePokemon(Pokemon pokemon) async {
    try {
      final bool resp  = await pokemonsLocalDataSource.capturePokemon(pokemon);
      // Right y Left es Dartz, 
      // Si todo sale bien retorna el valor de la derecha bool (true)
      return Right(resp);
    } on LocalFailure {
      // Left devuelve el Failure
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> getCapturedPokemons() async {
    try {
      final List<Pokemon> resp  = await pokemonsLocalDataSource.getCapturedPokemons();
      // Right y Left es Dartz, 
      // Si todo sale bien retorna el valor de la derecha bool (true)
      return Right(resp);
    } on LocalFailure {
      // Left devuelve el Failure
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemon(int id) async {
    try {
      final Pokemon resp  = await pokemonsRemoteDataSource.getPokemon(id);
      // Right y Left es Dartz, 
      // Si todo sale bien retorna el valor de la derecha bool (true)
      return Right(resp);
    } on DioException {
      // Left devuelve el Failure
      return Left(ServerFailure());
    }
  }
}