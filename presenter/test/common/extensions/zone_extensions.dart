import 'dart:async';

R? runZonedSync<R>(R Function() body) {
  return runZonedGuarded(
    body,
    (e, s) {},
    zoneSpecification: ZoneSpecification(
      scheduleMicrotask: (_, __, ___, microtask) {
        microtask();
      },
    ),
  );
}
