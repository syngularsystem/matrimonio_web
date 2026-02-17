import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveRsvp({
    required String name,
    required String email,
    required bool presence,
    required List<String> companions,
    required String attendance, // "sì" / "no"
    required String languageCode,
  }) async {
    try {
      final Map<String, dynamic> rsvpData = {
        'nome': name,
        'email': email,
        'presenza': presence,
        'accompagnatori': companions,
        'attendance': attendance,
        'timestamp': FieldValue.serverTimestamp(),
        'lingua': languageCode,
      };

      await _firestore.collection('rsvp_matrimonio').add(rsvpData);
    } catch (e) {
      // Rilancia l'errore per gestirlo nel Provider
      throw Exception("Errore salvataggio Firestore: $e");
    }
  }
}
