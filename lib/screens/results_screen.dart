import 'package:flutter/material.dart';
import '../services/voting_manager.dart';

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final results = VotingManager().getResults() ?? {};

    return Scaffold(
      appBar: AppBar(title: Text('Resultados de Votación')),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          String key = results.keys.elementAt(index);
          return ListTile(
            title: Text(key),
            trailing: Text('${results[key]} votos'),
          );
        },
      ),
    );
  }
}
