import 'dart:convert';

import 'package:core/common.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/event.dart';

@singleton
class EventApi {
  final Client _httpClient;

  const EventApi({required Client client}) : _httpClient = client;

  Future<List<Event>> findAll() async {
    final request = await _httpClient.get(
      Uri(
        scheme: "https",
        host: "5f5a8f24d44d640016169133.mockapi.io",
        path: "api/events",
      ),
    );
    final List<dynamic> rawBody = jsonDecode(
      utf8.decode(request.bodyBytes),
    );
    return rawBody.map((e) {
      return (e as Map<String, dynamic>).asDomain;
    }).toList(growable: false);
  }

  Future<Event> find({required String id}) async {
    final request = await _httpClient.get(
      Uri(
        scheme: "https",
        host: "5f5a8f24d44d640016169133.mockapi.io",
        path: "api/events/$id",
      ),
    );
    final Map<String, dynamic> rawBody = jsonDecode(
      utf8.decode(request.bodyBytes),
    );
    return rawBody.asDomain;
  }
}

extension _MapToEvent on Map<String, dynamic> {
  Event get asDomain => Event(
        id: (this["id"] as Object).orThrow(),
        title: (this["title"] as Object).orThrow(),
        description: (this["description"] as Object).orThrow(),
        price: (this["price"] as Object).orThrow(),
        date: DateTime.fromMillisecondsSinceEpoch(
          (this["date"] as int).orThrow(),
        ),
        image: (this["image"] as Object).orThrow(),
        latitude: (this["latitude"] as Object).orThrow(),
        longitude: (this["longitude"] as Object).orThrow(),
      );
}
