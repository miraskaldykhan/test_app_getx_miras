import 'package:get/get.dart';
import 'package:test_app_getx/services/repository.dart';

import '../models/character.dart';

class CharacterController extends GetxController{
  CharacterRepository characterRepository;

  CharacterController({required this.characterRepository});

  final character = Character().obs;
  final episodes = <Episode>[].obs;
  final isLoading = true.obs;
  final isLoadingEpisodes = true.obs;



  void loadCharacter(int id) async{
    isLoading(true);
    isLoadingEpisodes(true);
    try{
      var person = await characterRepository.getCharacterById(id);
      isLoading(false);
      character.value = person;
      episodes.value = await characterRepository.getEpisodes(character.value.episodeUrl!);
      isLoadingEpisodes(false);
    }catch(e){
      print(e);
    }
  }
}