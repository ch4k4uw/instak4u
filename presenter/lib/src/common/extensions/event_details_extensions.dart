import 'dart:convert';

import 'package:core/common.dart';
import 'package:messagepack/messagepack.dart';

import '../interaction/event_details_view.dart';

extension EventDetailsViewMarshalling on EventDetailsView {
  String marshall() {
    final packer = Packer();
    packer.packString(id);
    packer.packString(title);
    packer.packString(description);
    packer.packDouble(price);
    packer.packInt(date.microsecondsSinceEpoch >> 32);
    packer.packInt(date.microsecondsSinceEpoch & 0xffffffff);
    packer.packString(image);
    packer.packDouble(latitude);
    packer.packDouble(longitude);
    final bytes = packer.takeBytes();
    return Uri.encodeFull(base64Encode(bytes));
  }
}

extension StringToEventDetailsView on String {
  EventDetailsView unmarshallToEventDetailsView() {
    final bytes = base64Decode(Uri.decodeFull(this));
    final unPacker = Unpacker.fromList(bytes);
    final id = unPacker.unpackString();
    final title = unPacker.unpackString();
    final description = unPacker.unpackString();
    final price = unPacker.unpackDouble();
    final DateTime? date = unPacker.let((_) {
      final h = unPacker.unpackInt()?.let((it) => it << 32);
      final l = unPacker.unpackInt();
      if (h != null && l != null) {
        return DateTime.fromMicrosecondsSinceEpoch(h | l, isUtc: true);
      }
      return null;
    });
    final image = unPacker.unpackString();
    final lat = unPacker.unpackDouble();
    final long = unPacker.unpackDouble();
    var isNull = id == null;
    isNull = isNull || title == null;
    isNull = isNull || description == null;
    isNull = isNull || price == null;
    isNull = isNull || date == null;
    isNull = isNull || image == null;
    isNull = isNull || lat == null;
    isNull = isNull || long == null;
    if (isNull) {
      return EventDetailsView.empty;
    }
    return EventDetailsView(
      id: id,
      title: title,
      description: description,
      price: price,
      date: date,
      image: image,
      latitude: lat,
      longitude: long,
    );
  }
}
