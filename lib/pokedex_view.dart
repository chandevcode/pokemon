import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/bloc/nav_cubit.dart';

import 'bloc/pokemon_bloc.dart';
import 'bloc/pokemon_state.dart';

class PokedexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonPageLoadSuccess) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: state.pokemonListings.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => BlocProvider.of<NavCubit>(context)
                      .showPokemonDetails(state.pokemonListings[index].id),
                  child: Card(
                    child: GridTile(
                      child: Column(
                        children: [
                          Image.network(
                            state.pokemonListings[index].imageUrl,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            state.pokemonListings[index].name.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is PokemonPageLoadFailed) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
