// lib/models/voting.dart

class Voting {
  String question;
  List<String> options;
  Map<String, int> results;

  Voting({required this.question, required this.options})
      : results = Map.fromIterable(options, key: (item) => item, value: (item) => 0);

  void vote(String option) {
    if (results.containsKey(option)) {
      results[option] = (results[option] ?? 0) + 1;
    }
  }
}
