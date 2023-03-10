import 'package:get/get.dart';
import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/models/categories.dart';
import 'package:griha/app/models/posts.dart';
import 'package:griha/app/utils/constants.dart';

class DetailCategoryController extends GetxController {
  Category category = Get.arguments;

  Rx<List<Posts>>? posts;
  @override
  Future<void> onInit() async {
    super.onInit();
    await getPosts();
  }

  Future<void> getPosts() async {
    try {
      var res =
          await services.getPosts(categoryId: category.categoryId.toString());

      if (res is List<Posts>) {
        posts = Rx<List<Posts>>(res);
        // mapFavpost();
      } else if (res is ApiResponse && !res.isSucces) {
        posts = Rx<List<Posts>>([]);
      } else {
        posts = null;
      }
    } catch (e) {
      print(e);
    } finally {
      update(['posts']);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
