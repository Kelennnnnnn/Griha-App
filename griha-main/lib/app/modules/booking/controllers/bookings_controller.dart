import 'package:get/get.dart';
import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/models/bookings.dart';
import 'package:griha/app/utils/constants.dart';

class BookingsController extends GetxController {
  Rx<List<Bookings>>? bookingRequests;
  Rx<List<Bookings>>? myBookings;
  Rx<int> initialIndex = 0.obs;

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await getBookingRequests();
    await getMyBookings();
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

  Future<void> getBookingRequests() async {
    try {
      var res = await services.getBookingRequests();

      if (res is List<Bookings>) {
        bookingRequests = Rx<List<Bookings>>(res.obs);
      } else if (res is ApiResponse) {
        print('Error: ${res.message}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      update(['bookingRequests']);
    }
  }

  Future<void> getMyBookings() async {
    try {
      var res = await services.getMyBookings();

      if (res is List<Bookings>) {
        myBookings = Rx<List<Bookings>>(res.obs);
      } else if (res is ApiResponse) {
        print('Error: ${res.message}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      update(['myBookings']);
    }
  }
}
