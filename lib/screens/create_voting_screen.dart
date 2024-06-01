import 'package:flutter/material.dart';
import '../services/voting_manager.dart';

class CreateVotingScreen extends StatefulWidget {
  @override
  _CreateVotingScreenState createState() => _CreateVotingScreenState();
}

class _CreateVotingScreenState extends State<CreateVotingScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionController = TextEditingController();
  List<String> options = [];

  void _addOption() {
    final text = _optionController.text;
    if (text.isNotEmpty) {
      setState(() {
        options.add(text);
        _optionController.clear();
      });
    }
  }

  void _createVoting() {
    if (_questionController.text.isNotEmpty && options.length >= 2) {
      VotingManager().createVoting(_questionController.text, options);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Nueva Votación')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: 'Pregunta de la votación',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _optionController,
                decoration: InputDecoration(
                  labelText: 'Opción',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _addOption(),
              ),
            ),
            ElevatedButton(
              onPressed: _addOption,
              child: Text('Agregar Opción'),
            ),
            ElevatedButton(
              onPressed: _createVoting,
              child: Text('Crear Votación'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(options[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => setState(() => options.removeAt(index)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
