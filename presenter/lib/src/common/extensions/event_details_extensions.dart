import 'dart:convert';

import 'package:core/common/extensions/object_extensions.dart';
import 'package:messagepack/messagepack.dart';

import '../interaction/event_details_view.dart';

extension EventDetailsViewMarshalling on EventDetailsView {
  String marshall() {
    final packer = Packer();
    packer.packString(id);
    packer.packString(title);
    packer.packString(description);
    packer.packDouble(price);
    packer.packInt(date.microsecondsSinceEpoch);
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
    final DateTime? date = unPacker.unpackInt()?.let((it) {
      return DateTime.fromMicrosecondsSinceEpoch(it, isUtc: true);
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
