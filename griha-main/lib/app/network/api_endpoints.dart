class APIs {
  static const String ipAddress = "http://192.168.30.124:5001";
  static const String baseUrl = "$ipAddress/api";
  static const String login = "/auth/login";
  static String getUserDetails = "/user/";
  static const String register = "/auth/register";
  static String updateUserDetails = "/user/";
  static var post = ({required String userId}) => "/post/$userId";
  static var getPosts = '/post';
  static var deletePost = ({required String postId}) => '/post/$postId';
  static String city = "/city";
  static String category = "/category";

  static String bokings = "/fav/";
  static String changePassword = "/user/password/";
  static var makeBooking = ({required String userId}) => "/post/book/$userId";
  static var checkBooking =
      ({required String userId}) => "/post/checkBooking/$userId";
  static var getMyBookings =
      ({required String userId}) => "/post/myBookings/$userId";
  static var getBookingRequests =
      ({required String userId}) => "/post/bookingRequests/$userId";
  static var khaltiKey = 'test_public_key_dde0878862604f24b2475a9806c833d2';
}
