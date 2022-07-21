import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/data/pokemon_info_response.dart';
import 'package:pokemon/data/pokemon_repository.dart';
import 'package:pokemon/data/pokemon_species_info.dart';

import '../data/pokemon_details.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetails> {
  final _pokemonRepository = PokemonRepository();

  PokemonDetailsCubit() : super(null);

  void getPokemonDetails(int pokemonId) async {
    final response = await Future.wait([
      _pokemonRepository.getPokemonInfo(pokemonId),
      _pokemonRepository.getPokemonSpeciesInfo(pokemonId)
    ]);

    final pokemonInfo = response[0] as PokemonInfoResponse;
    final speciesInfo = response[1] as PokemonSpeciesInfoResponse;

    emit(PokemonDetails(
        id: pokemonInfo.id,
        name: pokemonInfo.name,
        imageUrl: pokemonInfo.imageUrl,
        types: pokemonInfo.types,
        height: pokemonInfo.height,
        weight: pokemonInfo.weight,
        description: speciesInfo.description));
  }

  void clearPokemonDetails() => emit(null);
}
