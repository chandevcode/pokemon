import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/app_navigator.dart';
import 'package:pokemon/bloc/nav_cubit.dart';
import 'package:pokemon/bloc/pokemon_bloc.dart';
import 'package:pokemon/bloc/pokemon_details_cubit.dart';
import 'package:pokemon/bloc/pokemon_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final pokemonDetailsCubit = PokemonDetailsCubit();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                PokemonBloc()..add(PokemonPageRequest(page: 0))),
        BlocProvider(
            create: (context) =>
                NavCubit(pokemonDetailsCubit: pokemonDetailsCubit)),
        BlocProvider(create: (context) => pokemonDetailsCubit)
      ], child: AppNavigator()),
    );
  }
}
