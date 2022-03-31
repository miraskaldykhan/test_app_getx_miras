import 'package:get/get.dart';
import 'package:test_app_getx/controllers/character_controller.dart';
import 'package:test_app_getx/services/provider.dart';
import 'package:test_app_getx/services/repository.dart';

import 'controllers/store_controller.dart';

class StoreBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => StoreController(repository: CharacterRepository()));
  }
}
