import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/character.dart';
import '../services/repository.dart';

class StoreController extends GetxController {
  CharacterRepository repository;
  StoreController({required this.repository});

  final charactersList = <Character>[].obs;
  final oldCharactersList = <Character>[].obs;
  final page = 1.obs;
  final isLoading = true.obs;
  final isFirstFetch = false.obs;


  static StoreController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    loadCharacters();
  }

  void loadCharacters() async{
    isLoading(true);
    if(page.value == 1){
      isFirstFetch(true);
    }else{
      isFirstFetch(false);
    }
    try{
      var characters = await repository.getCharactersList(page.value);
      isLoading(false);
      charactersList.addAll(characters);
      oldCharactersList.addAll(charactersList);
      page.value++;
    }catch(e){
      print(e);
    }
  }

}