import 'package:flutter/material.dart';
import '../data/services/firestore_service.dart';

enum RsvpStatus { idle, loading, success, error }

class RSVPProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  RsvpStatus _status = RsvpStatus.idle;
  String? _errorMessage;

  RsvpStatus get status => _status;
  String? get errorMessage => _errorMessage;

  Future<void> submitRSVP({
    required String name,
    required String email,
    required bool presence,
    required List<String> companions,
    required String attendance,
    required String languageCode,
  }) async {
    _status = RsvpStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _firestoreService.saveRsvp(
        name: name,
        email: email,
        presence: presence,
        companions: companions,
        attendance: attendance,
        languageCode: languageCode,
      );
      _status = RsvpStatus.success;
    } catch (e) {
      _status = RsvpStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  // Resetta lo stato dopo aver mostrato lo SnackBar o chiuso il form
  void reset() {
    _status = RsvpStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }
}
