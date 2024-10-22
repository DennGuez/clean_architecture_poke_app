import 'package:clean_architecture_poke_app/features/pokemon/data/datasources/pokemons_local_data_source.dart';
import 'package:clean_architecture_poke_app/features/pokemon/data/datasources/pokemons_remote_data_sources.dart';
import 'package:clean_architecture_poke_app/features/pokemon/data/repos/pokemons_repo_impl.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/repos/pokemons_repo.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/use_cases/capture_pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/use_cases/get_caputed_pokemons.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/use_cases/get_pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemon/presentation/bloc/search_pokemon/search_pokemon_bloc.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

// Inicializamos todos los services, (inyección de dependencias)
Future<void> init() async {
  // Datasources*
  di.registerLazySingleton<PokemonsLocalDataSource>(() => HivePokemonsLocalDataSourceImpl());
  di.registerLazySingleton<PokemonsRemoteDataSource>(() => PokemonsRemoteDataSourceImpl());
  // Ejemplo de uso de SQLite
  // di.registerLazySingleton<PokemonsLocalDataSource>(() => SQLPokemonLocalDataSourceImpl())

  // Repositories* (Implementamos los DataSources)
  di.registerLazySingleton<PokemonsRepo>(() => PokemonsRepoImpl(
    pokemonsLocalDataSource: di(), 
    pokemonsRemoteDataSource: di()
  ));

  // Use cases* (Implementamos los Repositories)
  di.registerLazySingleton(() => CapturePokemonUseCase(repo: di()));
  di.registerLazySingleton(() => GetCapturedPokemonsUseCase(repo: di()));
  di.registerLazySingleton(() => GetPokemonUseCase(repo: di()));

  // Bloc* (Implementamos los UseCases)
  // di.registerFactory(() => SearchPokemonBloc(
  //   _capturePokemonUseCase, 
  //   _getCapturedPokemonsUseCase, 
  //   _getPokemonUseCase))
  di.registerFactory(() => SearchPokemonBloc(di(), di(), di()));  
}