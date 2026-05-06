import 'package:flutter/material.dart';
import '../data/models/rsvp_model.dart';
import '../data/services/firestore_service.dart';

enum AdminStatus { idle, loading, success, error }

class AdminController extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  AdminStatus _status = AdminStatus.idle;
  String? _errorMessage;
  List<RsvpModel> _rsvps = [];

  AdminStatus get status => _status;
  String? get errorMessage => _errorMessage;
  List<RsvpModel> get rsvps => _rsvps;

  // Statistiche rapide per la dashboard
  int get totalRsvps => _rsvps.length;
  int get confirmedCount => _rsvps.where((r) => r.presence).length;
  int get declinedCount => _rsvps.where((r) => !r.presence).length;
  int get totalCompanions => _rsvps.fold(0, (sum, r) => sum + r.companions.length);
  int get totalGuests => confirmedCount + totalCompanions;

  Future<void> fetchRsvps() async {
    _status = AdminStatus.loading;
    _errorMessage = null;
    // Non pulisco i dati esistenti per evitare sfarfallii se sto solo aggiornando
    notifyListeners();

    try {
      _rsvps = await _firestoreService.getRsvps();
      _status = AdminStatus.success;
    } catch (e) {
      _status = AdminStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }
}
