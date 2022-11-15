class CheckInRequest {
  final String eventId;
  final String name;
  final String email;

  const CheckInRequest({
    required this.eventId,
    required this.name,
    required this.email,
  });

  @override
  String toString() {
    return 'CheckInRequest{eventId: $eventId, name: $name, email: $email}';
  }
}
