import 'package:flutter/material.dart';
import 'models/voting.dart'; // Asegúrate de que la ruta al archivo del modelo es correcta

class CreateVotingScreen extends StatefulWidget {
  @override
  _CreateVotingScreenState createState() => _CreateVotingScreenState();
}

class _CreateVotingScreenState extends State<CreateVotingScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionController = TextEditingController();
  List<String> options = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Nueva Votación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: 'Pregunta de la Votación',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _optionController,
              decoration: InputDecoration(
                labelText: 'Añadir Opción',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _addOption(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addOption,
              child: Text('Agregar Opción'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(options[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeOption(index),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _createVoting,
              child: Text('Crear Votación'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  void _addOption() {
    final text = _optionController.text;
    if (text.isNotEmpty) {
      setState(() {
        options.add(text);
        _optionController.clear();
      });
    }
  }

  void _removeOption(int index) {
    setState(() {
      options.removeAt(index);
    });
  }

  void _createVoting() {
    if (_questionController.text.isNotEmpty && options.isNotEmpty) {
      Voting newVoting = Voting(question: _questionController.text, options: options);
      Navigator.pop(context, newVoting); // Opcional: pasar la votación creada de vuelta
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _optionController.dispose();
    super.dispose();
  }
}
