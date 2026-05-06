class RsvpModel {
  final String id;
  final String name;
  final String email;
  final bool presence;
  final List<String> companions;
  final String attendance;
  final DateTime? timestamp;
  final String languageCode;

  RsvpModel({
    required this.id,
    required this.name,
    required this.email,
    required this.presence,
    required this.companions,
    required this.attendance,
    this.timestamp,
    required this.languageCode,
  });

  factory RsvpModel.fromMap(String id, Map<String, dynamic> data) {
    return RsvpModel(
      id: id,
      name: data['nome'] ?? '',
      email: data['email'] ?? '',
      presence: data['presenza'] ?? false,
      companions: List<String>.from(data['accompagnatori'] ?? []),
      attendance: data['attendance'] ?? '',
      timestamp: data['timestamp'] != null ? data['timestamp'].toDate() : null,
      languageCode: data['lingua'] ?? 'it',
    );
  }
}
