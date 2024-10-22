import 'package:clean_architecture_poke_app/features/pokemon/presentation/bloc/search_pokemon/search_pokemon_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemon/presentation/screens/pokemons_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:clean_architecture_poke_app/core/di.dart';

void main() async {
  // Antes de correr la aplicacon corremos el Init(), que seria toda nuesta inyeccion de dependencias
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      // Le decimos que el bloc de SearchPokemonBloc se proveera con el context
      // El GetIt buscara de todas las instacias que hicimos (inyeccion de dependencias), el SearchPokemonBloc
        BlocProvider(create: (_) => GetIt.instance.get<SearchPokemonBloc>())
      ],
      child: MaterialApp(
        title: 'Pokemon APP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PokemonsScreen(),
      ),
    );
  }
}
