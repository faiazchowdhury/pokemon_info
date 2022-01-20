import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_info/Model/AllPokemon.dart';
import 'package:pokemon_info/Widgets/CarouselContainer.dart';
import 'package:pokemon_info/bloc/loaddetails_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int offset = 0, currentIndex = 0;

  List<Widget> widgaet = [CarouselContainerLoader()];
  final bloc = new LoaddetailsBloc();
  AllPokemon pokemons;
  List<String> type = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    pokemons = new AllPokemon();
    bloc.add(LoadPokemon(pokemons, offset));
    offset = offset + 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocProvider(
            create: (context) => bloc,
            child: BlocListener(
              bloc: bloc,
              listener: (context, state) {
                if (state is LoaddetailsLoaded) {
                  if (state.statusCode == 200) {
                    pokemons = state.allPokemon;
                    widgaet.removeLast();
                    for (int i = offset - 10; i < offset; i++) {
                      widgaet.add(CarouselContainer(
                          pokemons.pokemons[i].imageUrl,
                          pokemons.pokemons[i].id));
                      String tempType = "";
                      for (int j = 0;
                          j < pokemons.pokemons[i].types.length;
                          j++) {
                        if (tempType == "") {
                          tempType = pokemons.pokemons[i].types[j].name;
                        } else {
                          tempType = tempType +
                              "/" +
                              pokemons.pokemons[i].types[j].name;
                        }
                      }
                      type.add(tempType);
                    }
                    if (offset < 150) {
                      widgaet.add(CarouselContainerLoader());
                    }
                  } else {
                    offset = offset - 10;
                  }
                  setState(() {});
                }
              },
              child: BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is LoaddetailsInitial ||
                        state is LoaddetailsLoading) {
                      return carousel();
                    } else {
                      if (state is LoaddetailsLoaded) {
                        if (state.statusCode == 200) {
                          return carousel();
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    }
                  }),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: pokemons.pokemons != null ? info(pokemons) : Container(),
          )
        ],
      ),
    );
  }

  Widget carousel() {
    return CarouselSlider(
      items: widgaet,
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          if (index == offset - 8 && offset < 150) {
            bloc.add(LoadPokemon(pokemons, offset));
            offset = offset + 10;
          }
          setState(() {
            currentIndex = index;
          });
        },
        enableInfiniteScroll: false,
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.3,
        height: MediaQuery.of(context).size.height * 0.2,
        aspectRatio: 4,
        disableCenter: true,
        initialPage: 1,
      ),
    );
  }

  Widget info(AllPokemon pokemons) {
    for (int i = 0; i < pokemons.pokemons.length; i++) {}
    return Column(
      children: [
        Text(
          pokemons.pokemons[currentIndex].name.substring(0, 1).toUpperCase() +
              pokemons.pokemons[currentIndex].name.substring(1),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Center(
                child: Text(
                  "Height: ${pokemons.pokemons[currentIndex].height}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              )),
              Expanded(
                  child: Center(
                child: Text(
                  "Weight: ${pokemons.pokemons[currentIndex].weight}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              )),
            ]),
        SizedBox(
          height: 20,
        ),
        Text(
          type.length == currentIndex ? "" : "Type: " + type[currentIndex],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )
      ],
    );
  }
}
