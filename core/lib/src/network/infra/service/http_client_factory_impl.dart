import '../../domain/service/http_client_factory.dart';
import '../service/http_logger_factory.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:injectable/injectable.dart';

import 'http_handler_factory.dart';

@Singleton(as: HttpClientFactory)
class HttpClientFactoryImpl implements HttpClientFactory {
  final HttpLoggerFactory _loggerFactory;
  final HttpHandlerFactory _handlerFactory;

  const HttpClientFactoryImpl({
    required HttpLoggerFactory loggerFactory,
    required HttpHandlerFactory handlerFactory,
  })  : _loggerFactory = loggerFactory,
        _handlerFactory = handlerFactory;

  @override
  Client create() => InterceptedClient.build(
        interceptors: [
          _loggerFactory.create(),
          _handlerFactory.create(),
        ],
      );
}
