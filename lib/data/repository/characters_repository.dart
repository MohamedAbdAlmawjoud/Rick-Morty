import 'package:rick_and_morty/data/apis/characters_api.dart';
import 'package:rick_and_morty/data/models/characters_model.dart';

class CharactersRepository {
  final CharactersApi charactersApi ;

  CharactersRepository(this.charactersApi);

  Future<List<CharactersModel>> getAllCharacters()async{
    final characters = await charactersApi.getAllCharacters();
    return characters.map((character)=> CharactersModel.fromJson(character)).toList();
  }
}