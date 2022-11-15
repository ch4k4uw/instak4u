import 'dart:convert';

import 'package:domain/src/check_in/infra/remote/model/check_in_request.dart';
import 'package:injectable/injectable.dart';

import 'package:http/http.dart';

@singleton
class CheckInApi {
  final Client _httpClient;

  const CheckInApi({required Client client}) : _httpClient = client;

  Future<void> performCheckIn({required CheckInRequest event}) async {
    await _httpClient.post(
      Uri(
        scheme: "https",
        host: "5f5a8f24d44d640016169133.mockapi.io",
        path: "api/checkin",
      ),
      body: event.asRequest,
    );
  }
}

extension _CheckInRequestExtension on CheckInRequest {
  Map<String, String> get asRequest => {
        "eventId": eventId,
        "name": name,
        "email": email,
      };
}
