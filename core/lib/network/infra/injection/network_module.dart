import 'package:core/network/infra/service/http_handler_factory.dart';
import 'package:core/network/infra/service/http_logger_factory.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  HttpLoggerFactory getHttpLoggerFactory() => HttpLoggerFactory();

  @singleton
  HttpHandlerFactory getHttpHandlerFactory() => HttpHandlerFactory();

}
