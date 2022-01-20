part of 'loaddetails_bloc.dart';

@immutable
abstract class LoaddetailsEvent {}

class LoadPokemon extends LoaddetailsEvent {
  final AllPokemon allPokemon;
  final int offset;
  LoadPokemon(this.allPokemon, this.offset);
}
