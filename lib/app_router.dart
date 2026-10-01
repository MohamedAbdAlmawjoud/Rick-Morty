import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data/apis/characters_api.dart';
import 'package:rick_and_morty/data/models/characters_model.dart';
import 'package:rick_and_morty/data/repository/characters_repository.dart';
import 'package:rick_and_morty/logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty/presentation/screens/characters_details_screen.dart';
import 'package:rick_and_morty/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersApi());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                charactersCubit ,
            child: CharactersScreen(),
          ),
        );
      case charactersDetailsScreen:
      final character = settings.arguments as CharactersModel;
        return MaterialPageRoute(builder: (_) => CharactersDetails(character: character));
    }
    return null;
  }
}
