import 'package:clean_architecture_poke_app/core/error/failures.dart';
import 'package:clean_architecture_poke_app/features/pokemon/data/models/pokemon_model.dart';
import 'package:clean_architecture_poke_app/features/pokemon/domain/entities/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class PokemonsLocalDataSource {
  Future<bool> capturePokemon(Pokemon pokemon);
  Future<List<Pokemon>> getCapturedPokemons();
}

class HivePokemonsLocalDataSourceImpl implements PokemonsLocalDataSource {

  // Hive requiere que lo inicialicemos, para que pueda guardar datos en el dispositivo
  HivePokemonsLocalDataSourceImpl(){
    Hive.initFlutter();
  }

  @override
  Future<bool> capturePokemon(Pokemon pokemon) async {
    try {
      Box<dynamic> box = await Hive.openBox('pokemons');
      // Creamos el dato dentro de la box donde el key: pokemon.id y el value: todo el string del json
      box.put(pokemon.id, PokemonModel.fromEntity(pokemon).toJson());
      return true;
    } catch (e) {
      // Hace un print en modo debug para ver el error
      debugPrint(e.toString());
      throw LocalFailure();
    }
  }

  @override
  Future<List<Pokemon>> getCapturedPokemons() async {
    try {
      Box<dynamic> box = await Hive.openBox('pokemons');

      // Usamos toList para pasar de iterable a lista
      return box.values.map((pokemon) => PokemonModel.fromJson(pokemon)).toList();
    } catch (e) {
      // Hace un print en modo debug para ver el error
      debugPrint(e.toString());
      throw LocalFailure();
    }
  }
}

// class SqlLitePokemonsLocalDataSourceImpl implements PokemonsLocalDataSource {}