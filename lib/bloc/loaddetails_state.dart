part of 'loaddetails_bloc.dart';

@immutable
abstract class LoaddetailsState {}

class LoaddetailsInitial extends LoaddetailsState {}

class LoaddetailsLoading extends LoaddetailsState {}

class LoaddetailsLoaded extends LoaddetailsState {
  final int statusCode;
  final AllPokemon allPokemon;
  LoaddetailsLoaded(this.statusCode, this.allPokemon);
}
