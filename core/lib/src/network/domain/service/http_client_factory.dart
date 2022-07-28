import 'package:http/http.dart';

abstract class HttpClientFactory {
  Client create();
}