import 'package:pokemon_info/Model/AllDetailsOfPokemon.dart';

class AllPokemon {
  List<AllDetailsOfPokemon> pokemons = [];

  AllPokemon({this.pokemons});
  addPokemon(AllDetailsOfPokemon poke) {
    print(poke.id);
    if (pokemons == null) {
      pokemons = [poke];
    } else {
      pokemons.add(poke);
    }
  }
}
