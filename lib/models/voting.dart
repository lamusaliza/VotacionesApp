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

  Map<String, dynamic> toJson() => {
    'question': question,
    'options': options,
    'results': results,
  };

  static Voting fromJson(Map<String, dynamic> json) {
    Voting voting = Voting(question: json['question'], options: List<String>.from(json['options']));
    voting.results = Map.from(json['results']);
    return voting;
  }
}
