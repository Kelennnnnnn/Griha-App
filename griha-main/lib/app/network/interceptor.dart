import 'package:dio/dio.dart';
import 'package:griha/app/utils/memory_management.dart';

class Logging extends Interceptor {
  Dio dio = Dio();

  Logging({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(options.uri);
    options.headers.addAll(
      ({
        "Authorization": "Bearer ${MemoryManagement.getAccessToken()}",
        "Connection": "keep-alive",
      }),
    );
    return super.onRequest(options, handler);
  }
}
