import 'package:get/get.dart';

import '../controllers/detailed_post_controller.dart';

class DetailedPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailedPostController>(
      () => DetailedPostController(),
    );
  }
}
