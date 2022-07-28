import 'package:core/common.dart';

class EventDetailsView {
  final String id;
  final String title;
  final String description;
  final double price;
  final DateTime? _date;
  final String image;
  final double latitude;
  final double longitude;

  const EventDetailsView({
    this.id = "",
    this.title = "",
    this.description = "",
    this.price = 0.0,
    DateTime? date,
    this.image = "",
    this.latitude = 0.0,
    this.longitude = 0.0,
  }) : _date = date;

  static const EventDetailsView empty = EventDetailsView();

  DateTime get date => _date ?? emptyDate;

  @override
  operator ==(Object? other) {
    if (other is! EventDetailsView) {
      return false;
    }
    var result = id == other.id;
    result = result && title == other.title;
    result = result && description == other.description;
    result = result && price == other.price;
    result = result && date == other.date;
    result = result && image == other.image;
    result = result && latitude == other.latitude;
    result = result && longitude == other.longitude;
    return result;
  }

  @override
  int get hashCode => Object.hash(
        id,
        title,
        description,
        price,
        date,
        image,
        latitude,
        longitude,
      );

  @override
  String toString() {
    return 'EventDetailsView{id: $id, title: $title, description: $description, price: $price, date: $date, image: $image, latitude: $latitude, longitude: $longitude}';
  }
}
