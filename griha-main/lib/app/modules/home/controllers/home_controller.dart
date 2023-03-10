import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/models/bookings.dart';
import 'package:griha/app/models/categories.dart';
import 'package:griha/app/models/posts.dart';
import 'package:griha/app/modules/booking/controllers/bookings_controller.dart';
import 'package:griha/app/modules/my_properties/controllers/my_properties_controller.dart';

import 'package:griha/app/modules/profile/controllers/profile_controller.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<List<Posts>>? posts;
  Rx<bool> isFavouriteLoading = false.obs;

  Categories? categories;
  // Rx<List<Posts>>? bokingspost;
  ProfileController profileController = Get.put(ProfileController());
  BookingsController bookingsController = Get.put(BookingsController());

  final count = 0.obs;
  Rx<bool> selectThisWeek = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    await getCategories();
    await getPosts();
    // await getStats();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getCategories() async {
    try {
      var res = await services.getCategories();

      if (res is Categories) {
        categories = res;

        update(['categories']);
      } else {
        categories = Categories();
      }
    } catch (e) {
      print(e);
    } finally {
      update(['categories']);
    }
  }

  Future<void> onRefresh() async {
    await getPosts();
    await getCategories();
    await bookingsController.getBookingRequests();
    await bookingsController.getMyBookings();
    // await myPropertiesController.getPosts();
  }

  Future<void> getPosts() async {
    try {
      var res = await services.getPosts();

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
}
