

import '../models/character.dart';
import 'provider.dart';

class CharacterRepository {
  final StoreProvider _storeProvider = StoreProvider();
  final CharacterProvider _characterProvider = CharacterProvider();

  List<Character> readCharactersFromStorage() => _storeProvider.readCharactersFromStorage();
  void writeCharactersToStorage(List<Character> characters) =>
      _storeProvider.writeCharacterToStorage(characters);

  Future<List<Character>> getCharactersList(int page) => _characterProvider.getCharactersList(page);
  Future<Character> getCharacterById(int id) => _characterProvider.getCharacterById(id);

  Future<List<Episode>> getEpisodes(List<String> urls) => _characterProvider.getEpisodes(urls);
}