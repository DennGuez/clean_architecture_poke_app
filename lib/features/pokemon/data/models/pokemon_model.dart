import 'package:clean_architecture_poke_app/features/pokemon/domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({required super.name, required super.image, required super.id});

  // Creamos un PokemonModel a partir de un json que nos devuelve el servidor API
  factory PokemonModel.fromJson(json) {
    return PokemonModel(
      name: json['name'],
      image: json['sprites']['front_default'],
      id: json['id'],
    );
  }

  // Convierte el PokemonModel a un json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sprites': {
        'front_default': image,
      },
      'id': id,
    };
  }

  // Creamos un PokemonModel a partir de un Pokemon(Entity)
  factory PokemonModel.fromEntity(Pokemon pokemon) {    
    return PokemonModel(
      name: pokemon.name,
      image: pokemon.image,
      id: pokemon.id,
    );
  }
}