import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presenter/common.dart';

import '../stuff/event_details_view_fixture.dart';


void main() {
  test('encode event details', () {
    const event = EventDetailsViewFixture.eventDetails;
    final encoded = event.marshall();
    final decoded = encoded.unmarshallToEventDetailsView();
    expect(decoded, equals(event));
  });
}