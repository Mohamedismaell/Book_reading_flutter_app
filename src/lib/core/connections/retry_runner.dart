import 'package:bookreading/core/connections/retry_queue.dart';
import 'package:dio/dio.dart';

class RetryRunner {
  RetryRunner(this.dio, this.queue);

  final Dio dio;
  final RetryQueue queue;

  Future<void> retryAll() async {
    if (queue.isEmpty) return;

    final requests = queue.drain();
    for (final options in requests) {
      try {
        await dio.fetch(options);
      } catch (_) {
        print('Can\'t retry request');
      }
    }
  }
}
