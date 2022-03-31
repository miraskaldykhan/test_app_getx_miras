import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:test_app_getx/controllers/store_controller.dart';
import 'package:test_app_getx/screens/characterCard.dart';

import 'constants/color_constants.dart';

class Home extends GetView<StoreController> {
  Home({Key? key}) : super(key: key);
  final scrollController = ScrollController();
  final storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        title: const Text("Rick and Morty by Miras"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (storeController.isFirstFetch.value && storeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                return CharacterCard(
                    character: storeController.charactersList[index]);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey[400],
                );
              },
              itemCount: storeController.charactersList.length,
            );
          }
        }),
      ),
    );
  }

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          //BlocProvider.of<PersonListCubit>(context).loadPerson();
          storeController.loadCharacters();
        }
      }
    });
  }
}
