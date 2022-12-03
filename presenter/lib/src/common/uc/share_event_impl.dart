import 'package:core/common.dart';
import 'package:domain/feed.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:presenter/src/common/extensions/build_context_extensions.dart';

import 'share_event.dart';

@Injectable(as: ShareEvent)
class ShareEventImpl implements ShareEvent {
  final BuildContext _context;
  final EventRepository _eventRepository;

  static const _maxTextLength = 512;

  ShareEventImpl({
    required BuildContext context,
    required EventRepository eventRepository,
  })  : _context = context,
        _eventRepository = eventRepository;

  @override
  Future<String> call({required String eventId}) async {
    final details = await _eventRepository.find(id: eventId);
    final context = _context;
    final strings = context.presenterString;
    final deepLink = {
      'scheme': strings.deepLinkHttpsScheme,
      'authority': strings.deepLinkAuthority,
      'merchant': strings.deepLinkMerchant(eventId),
    };
    final uri = Uri(
      scheme: deepLink['scheme'],
      host: deepLink['authority'],
      path: deepLink['merchant'],
    );

    return _context.presenterString.eventSharing(
      details.title,
      details.description.let((it) {
        if (it.length > _maxTextLength) {
          return "${it.substring(0, _maxTextLength)}…";
        }
        return it;
      }),
      details.latitude,
      details.longitude,
      uri.toString(),
    );
  }
}
