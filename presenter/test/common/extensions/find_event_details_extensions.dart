import 'package:core/common.dart';
import 'package:mockito/mockito.dart';

import '../../feed/feed_view_model_test.mocks.dart' as feed_vm;
import '../../feed/stuff/events_fixture.dart';

extension FeedVMFindEventDetailsExtensions on feed_vm.MockFindEventDetails {
  void setup({Exception? exception}) {
    when(call(id: anyNamed("id"))).thenAnswer((realInvocation) {
      if (exception != null) {
        return Future.error(exception, StackTrace.current);
      }
      return EventsFixture.anEvent.asSynchronousFuture;
    });
  }
}