import 'package:core/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presenter/common.dart';
import 'package:presenter/src/common/uc/share_event.dart';
import 'package:presenter/src/event/event_details_view_model.dart';
import 'package:presenter/src/event/interaction/event_details_state.dart';
import 'package:presenter/src/event/uc/perform_check_in.dart';

import '../common/extensions/global_extensions.dart';
import '../common/extensions/perform_logout_extensions.dart';
import '../common/extensions/zone_extensions.dart';
import '../common/stuff/common_fixture.dart';
import '../ui_state_observer.dart';
import '../unawaited_future_runner.dart';
@GenerateNiceMocks([
  MockSpec<PerformCheckIn>(),
  MockSpec<ShareEvent>(),
  MockSpec<PerformLogout>(),
  MockSpec<UiStateObserver<EventDetailsState>>(),
])
import 'event_details_view_model_test.mocks.dart';

const _shareText = "xxx";

void main() {
  final futureRunner = UnawaitedFutureRunner();
  final performCheckIn = MockPerformCheckIn();
  final shareEvent = MockShareEvent();
  final performLogout = MockPerformLogout();
  final uiStateObserver = MockUiStateObserver();

  late EventDetailsViewModel vm;

  setUp(() {
    performLogout.setup();
    vm = EventDetailsViewModel(
      futureRunner: futureRunner,
      eventDetails: CommonFixture.presenter.event,
      performCheckIn: performCheckIn,
      shareEvent: shareEvent,
      performLogout: performLogout,
    )..uiState.listen(uiStateObserver);

    disableLog();
  });

  group('event details', () {
    group('check-in', () {
      test('it should perform check-in', () async {
        performCheckIn.setup();
        runZonedSync(() {
          futureRunner.advanceUntilIdle();
          vm.performCheckIn();
          futureRunner.advanceUntilIdle();
        });

        verifyInOrder([
          uiStateObserver(
            EventDetailsStateDisplayDetails(
              eventDetails: CommonFixture.presenter.event,
            ),
          ),
          uiStateObserver(EventDetailsState.loading),
          performCheckIn(eventId: anyNamed("eventId")),
          uiStateObserver(EventDetailsState.successfulCheckedIn),
        ]);
      });

      test('it shouldn\'t perform check-in', () async {
        performCheckIn.setup(exception: Exception());
        runZonedSync(() {
          futureRunner.advanceUntilIdle();
          vm.performCheckIn();
          futureRunner.advanceUntilIdle();
        });

        verifyInOrder([
          uiStateObserver(
            EventDetailsStateDisplayDetails(
              eventDetails: CommonFixture.presenter.event,
            ),
          ),
          uiStateObserver(EventDetailsState.loading),
          performCheckIn(eventId: anyNamed("eventId")),
          uiStateObserver(EventDetailsState.notCheckedIn),
        ]);
      });
    });

    group('event sharing', () {
      test('it should share the event', () async {
        shareEvent.setup();

        runZonedSync(() {
          futureRunner.advanceUntilIdle();
          vm.shareEvent();
          futureRunner.advanceUntilIdle();
        });

        verifyInOrder([
          uiStateObserver(any),
          uiStateObserver(EventDetailsState.loading),
          shareEvent(eventId: anyNamed("eventId")),
          uiStateObserver(const EventDetailsStateShareEvent(text: _shareText)),
        ]);
      });

      test('it shouldn\'t share the event', () async {
        shareEvent.setup(exception: Exception());

        runZonedSync(() {
          futureRunner.advanceUntilIdle();
          vm.shareEvent();
          futureRunner.advanceUntilIdle();
        });

        verifyInOrder([
          uiStateObserver(any),
          uiStateObserver(EventDetailsState.loading),
          shareEvent(eventId: anyNamed("eventId")),
          uiStateObserver(EventDetailsState.eventNotShared),
        ]);
      });
    });

    test('it should perform logout', () async {
      performLogout.setup();

      runZonedSync(() {
        futureRunner.advanceUntilIdle();
        vm.logout();
        futureRunner.advanceUntilIdle();
      });

      verifyInOrder([
        uiStateObserver(any),
        uiStateObserver(any),
        performLogout(),
        uiStateObserver(EventDetailsState.successfulLoggedOut),
      ]);
    });
  });
}

extension _PerformCheckInExtensions on MockPerformCheckIn {
  void setup({Exception? exception}) {
    when(call(eventId: anyNamed("eventId"))).thenAnswer((realInvocation) {
      return exception?.let(
            (it) => Future.error(exception, StackTrace.current),
          ) ??
          SynchronousFuture(null);
    });
  }
}

extension _ShareEventExtensions on MockShareEvent {
  void setup({Exception? exception}) {
    when(call(eventId: anyNamed("eventId"))).thenAnswer((realInvocation) {
      return exception?.let(
            (it) => Future.error(exception, StackTrace.current),
          ) ??
          _shareText.asSynchronousFuture;
    });
  }
}
