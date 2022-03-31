import 'dart:convert';

import 'package:get/get.dart';
import 'package:test_app_getx/models/character.dart';

import '../constants/keys.dart';
import 'storage_service.dart';
import 'package:http/http.dart' as http;

class StoreProvider {
  final StorageService _storageService = Get.find<StorageService>();

  List<Character> readCharactersFromStorage() {
    var characters = <Character>[];
    jsonDecode(_storageService.read(characterKey).toString())
        .forEach((e) => characters.add(Character.fromJson(e)));
    return characters;
  }

  void writeCharacterToStorage(List<Character> characters) {
    _storageService.write(characterKey, jsonEncode(characters));
  }
}

class CharacterProvider {
  Future<List<Character>> getCharactersList(int page) async {
    final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return (jsonResponse['results'] as List)
          .map((character) => Character.fromJson(character))
          .toList();
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Future<Character> getCharacterById(int id) async {
    final response = await http
        .get(Uri.parse('https://rickandmortyapi.com/api/character/$id'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return Character.fromJson(jsonResponse);
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
  
  Future<List<Episode>> getEpisodes(List<String> urls) async{
    final List<Episode> episodes = [];
    var lengthOfEpisodes = urls.length > 10 ? 10: urls.length;
      for(int i = 0; i< lengthOfEpisodes; i++){
        final response = await http.get(Uri.parse(urls[i]));
        if(response.statusCode == 200){
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          episodes.add(Episode.fromJson(jsonResponse));
        }else{
          throw Exception('Error: ${response.reasonPhrase}');
        }
      }
      return episodes;
  }
}
