import 'package:bookreading/core/connections/network_info.dart';
import 'package:bookreading/core/connections/retry_queue.dart';
import 'package:bookreading/core/database/api/end_points.dart';
import 'package:bookreading/core/errors/exceptions/no_internet_exception.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final NetworkInfo networkInfo;
  final RetryQueue retryQueue;

  ApiInterceptor(this.networkInfo, this.retryQueue);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.baseUrl = EndPoints.baseUrl;

    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      retryQueue.add(options);
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const NoInternetException(),
          type: DioExceptionType.unknown,
        ),
      );
    }

    handler.next(options);
  }
}
