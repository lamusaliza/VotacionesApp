import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/voting.dart';
import 'database_helper.dart';

class VotingManager with ChangeNotifier {
  Voting? currentVoting;

  VotingManager() {
    loadVoting();
  }

  Future<void> createVoting(String question, List<String> options) async {
    currentVoting = Voting(
      question: question,
      options: options,
      votes: {for (var option in options) option: 0},
    );
    await DatabaseHelper.instance.create(currentVoting!);
    notifyListeners();
  }

  Future<void> vote(String option) async {
    if (currentVoting != null) {
      currentVoting!.votes[option] = (currentVoting!.votes[option] ?? 0) + 1;
      await DatabaseHelper.instance.update(currentVoting!);
      notifyListeners();
    }
  }

  Future<void> closeVoting() async {
    if (currentVoting != null) {
      await DatabaseHelper.instance.addToHistory(currentVoting!);
      await DatabaseHelper.instance.deleteCurrentVoting();
      currentVoting = null;
      notifyListeners();
    }
  }

  Future<void> loadVoting() async {
    currentVoting = await DatabaseHelper.instance.getCurrentVoting();
    notifyListeners();
  }

  Future<List<Voting>> getVotingHistory() async {
    return await DatabaseHelper.instance.getVotingHistory();
  }
}
