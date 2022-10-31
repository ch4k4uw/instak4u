class Event {
  final String id;
  final String title;
  final String description;
  final double price;
  final DateTime date;
  final String image;
  final double latitude;
  final double longitude;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.date,
    required this.image,
    required this.latitude,
    required this.longitude,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          price == other.price &&
          date == other.date &&
          image == other.image &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      date.hashCode ^
      image.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;

  Event copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    DateTime? date,
    String? image,
    double? latitude,
    double? longitude,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      date: date ?? this.date,
      image: image ?? this.image,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
