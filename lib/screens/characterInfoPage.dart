import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:test_app_getx/controllers/character_controller.dart';
import 'package:test_app_getx/services/repository.dart';

import '../constants/color_constants.dart';

class CharacterInfoPage extends StatelessWidget {
  CharacterInfoPage({Key? key}) : super(key: key);

  final characterController =
      Get.put(CharacterController(characterRepository: CharacterRepository()));

  @override
  Widget build(BuildContext context) {
    characterController.loadCharacter(Get.arguments);
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        title: Text("Character name"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cellBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(() {
            if (characterController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                        characterController.character.value.image!),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        characterController.character.value.name!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      (characterController.character.value.gender! == 'Female')
                          ? SvgPicture.asset(
                              'assets/icons/female.svg',
                              width: MediaQuery.of(context).size.width / 8,
                            )
                          : SvgPicture.asset(
                              'assets/icons/male.svg',
                              width: MediaQuery.of(context).size.width / 8,
                            ),
                      Text(
                        characterController.character.value.status!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "EPISODES : ",
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ],
                  ),
                  !characterController.isLoadingEpisodes.value
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(
                              itemBuilder: (context, index) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${characterController.episodes[index].name!}  || ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    characterController.episodes[index].episode!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              itemCount:
                                  (characterController.episodes.length > 10)
                                      ? 10
                                      : characterController.episodes.length,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Colors.grey[400],
                                );
                              },
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
