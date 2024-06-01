import 'package:shared_preferences/shared_preferences.dart';
import '../models/voting.dart'; // Asegúrate de que esta ruta sea correcta

class VotingManager {
  static final VotingManager _instance = VotingManager._internal();
  factory VotingManager() => _instance;
  VotingManager._internal();

  Voting? currentVoting;

  void createVoting(String question, List<String> options) {
    currentVoting = Voting(question: question, options: options);
    saveVoting();
  }

  void closeVoting() {
    currentVoting = null;
    clearVoting();
  }

  void saveVoting() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('currentVoting', currentVoting?.toJson().toString() ?? '');
  }

  Future<void> loadVoting() async {
    final prefs = await SharedPreferences.getInstance();
    String? votingJson = prefs.getString('currentVoting');
    if (votingJson != null) {
      currentVoting = Voting.fromJson(votingJson as Map<String, dynamic>);
    }
  }

  void clearVoting() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('currentVoting');
  }

  Map<String, int>? getResults() {
    return currentVoting?.results;
  }
}
