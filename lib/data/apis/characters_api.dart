import 'package:rick_and_morty/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersApi {

  late Dio dio ;

  CharactersApi(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters()async{
    try{
      Response response = await dio.get(charactersEndPoint);
      return List<dynamic>.from((response.data['results'] ?? []));
    }catch(e){
      return [];
    }
  }
}