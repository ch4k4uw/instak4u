import 'package:core/network/domain/data/app_http_bad_request_exception.dart';
import 'package:core/network/domain/data/app_http_generic_exception.dart';
import 'package:core/network/domain/data/app_http_internal_server_exception.dart';
import 'package:core/network/domain/data/app_http_not_found_exception.dart';
import 'package:core/network/domain/data/http_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class HttpHandlerFactory {
  InterceptorContract create() => _Interceptor();
}

class _Interceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async =>
      data;

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode >= 200 && data.statusCode <= 399) {
      return data;
    }
    _log(data: data.toString());
    switch (data.statusCode) {
      case HttpConstants.notFoundError:
        throw AppHttpNotFountException();
      case HttpConstants.badRequest:
        throw AppHttpBadRequestException();
      case HttpConstants.internalError:
        throw AppHttpInternalServerException();
      default:
        throw AppHttpGenericException();
    }
  }

  void _log({required String data}) {
    if (kDebugMode) {
      print(data);
    }
  }
}
