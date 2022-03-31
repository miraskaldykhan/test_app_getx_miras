import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:test_app_getx/constants/color_constants.dart';
import 'package:test_app_getx/models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      Get.toNamed('/character', arguments: character.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(character.image!),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  character.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                (character.gender! == 'Female')
                    ? SvgPicture.asset(
                        'assets/icons/female.svg',
                        width: MediaQuery.of(context).size.width / 8,
                      )
                    : SvgPicture.asset(
                        'assets/icons/male.svg',
                        width: MediaQuery.of(context).size.width / 8,
                      ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
