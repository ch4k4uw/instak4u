import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';

import '../../event/event_details_view_model_test.mocks.dart'
    as event_details_vm;
import '../../feed/feed_view_model_test.mocks.dart' as feed_vm;

extension FeedVMPerformLogoutExtensions on feed_vm.MockPerformLogout {
  void setup() {
    when(call()).thenAnswer(
      (realInvocation) => SynchronousFuture(null),
    );
  }
}

extension EventDetailsVMPerformLogoutExtensions
    on event_details_vm.MockPerformLogout {
  void setup() {
    when(call()).thenAnswer(
      (realInvocation) => SynchronousFuture(null),
    );
  }
}
