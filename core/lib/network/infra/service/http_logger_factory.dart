import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http_interceptor.dart';

class HttpLoggerFactory {
  InterceptorContract create() => _Interceptor();
}

class _Interceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    _log(data: data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    _log(data: data.toString());
    return data;
  }

  void _log({required String data}) {
    if (kDebugMode) {
      print(data);
    }
  }

}