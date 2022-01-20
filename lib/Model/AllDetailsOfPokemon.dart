import 'dart:convert';

class AllDetailsOfPokemon {
  AllDetailsOfPokemon(
      {this.height,
      this.weight,
      this.name,
      this.id,
      this.types,
      this.imageUrl});
  String height, weight, name, id, imageUrl;
  List<Types> types;

  factory AllDetailsOfPokemon.fromJson(Map<String, dynamic> json) =>
      AllDetailsOfPokemon(
        height: json["height"] == null ? null : json["height"].toString(),
        weight: json["weight"] == null ? null : json["weight"].toString(),
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"].toString(),
        imageUrl:
            json["sprites"] == null ? null : json["sprites"]["front_default"],
        types: json["types"] == null
            ? null
            : List<Types>.from(json["types"].map((x) => Types.fromJson(x))),
      );
}

class Types {
  Types({this.name});
  String name;
  factory Types.fromJson(Map<String, dynamic> json) =>
      Types(name: json["type"] == null ? null : json["type"]["name"]);
}
