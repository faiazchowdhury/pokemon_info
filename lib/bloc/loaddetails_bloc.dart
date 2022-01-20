import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:pokemon_info/Model/AllDetailsOfPokemon.dart';
import 'package:pokemon_info/Model/AllPokemon.dart';

import 'package:http/http.dart' as http;

part 'loaddetails_event.dart';
part 'loaddetails_state.dart';

class LoaddetailsBloc extends Bloc<LoaddetailsEvent, LoaddetailsState> {
  LoaddetailsBloc() : super(LoaddetailsInitial()) {
    on<LoaddetailsEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is LoadPokemon) {
        emit.call(LoaddetailsLoading());
        for (int i = 1; i <= 10; i++) {
          var response = await http.get(Uri.parse(
              "https://pokeapi.co/api/v2/pokemon/${event.offset + i}"));
          if (response.statusCode == 200) {
            AllDetailsOfPokemon temp =
                AllDetailsOfPokemon.fromJson(json.decode(response.body));
            event.allPokemon.addPokemon(temp);
          } else {
            emit.call(LoaddetailsLoaded(response.statusCode, event.allPokemon));
            break;
          }
        }
        emit.call(LoaddetailsLoaded(200, event.allPokemon));
      }
    });
  }
}
