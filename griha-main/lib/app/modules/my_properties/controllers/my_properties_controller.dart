import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/models/posts.dart';
import 'package:griha/app/modules/home/controllers/home_controller.dart';
import 'package:griha/app/utils/constants.dart';

class MyPropertiesController extends GetxController {
  Rx<List<Posts>>? posts;
  HomeController homeController = Get.put(HomeController());

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await getPosts();
  }

  Future<void> getPosts() async {
    try {
      var res = await services.getPosts(isMyPosts: true);

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

  Future<void> deletePost({required String postId}) async {
    try {
      var res = await services.deletePost(postId: postId);

      if (res is ApiResponse && res.isSucces) {
        showCustomSnackBar(message: res.message);
        await getPosts();
        await homeController.getPosts();
      }
    } on DioError catch (e) {
      print(e.response);
      showCustomSnackBar(message: 'Error while deleting post');
    } catch (e) {
      showCustomSnackBar(message: 'Something went wrong');
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

  void increment() => count.value++;
}
