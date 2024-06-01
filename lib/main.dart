import 'package:flutter/material.dart';
import 'screens/create_voting_screen.dart';
import 'screens/results_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación de Votación',
      debugShowCheckedModeBanner: false, // Esto elimina el banner de Debug
      theme: ThemeData(
        primarySwatch: Colors.purple, // Ajustado a un tema con base lila
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Color de fondo más claro
      body: SafeArea(
        child: SingleChildScrollView( // Permite el desplazamiento del contenido
          child: Column(
            children: <Widget>[
              header(),
              SizedBox(height: 30),
              buttonsGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomClipperHalf(),
          child: Container(
            height: 250,
            color: Colors.black,
          ),
        ),
        Positioned(
          top: 60,
          left: 20,
          right: 20,
          child: Container(
            height: 180,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Image.asset('assets/images/monster.png', width: 80),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bienvenido a la E-Vote',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[800],
                        ),
                      ),
                      Text(
                        'Votar es el poder de expresar tu voz y forjar el futuro; no dejes que otros decidan por ti.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 20, // Aumentado para más espacio entre botones
      mainAxisSpacing: 20, // Aumentado para más espacio entre botones
      childAspectRatio: 1.4, // Ajustado para hacer los botones más pequeños
      children: <Widget>[
        createButton('Crear Nueva Votación', Icons.add, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateVotingScreen()),
          );
        }),
        createButton('Continuar Votación', Icons.play_arrow, () {
          // Implementar la lógica para continuar votación
        }),
        createButton('Cerrar Votación', Icons.close, () {
          // Implementar la lógica para cerrar votación
        }),
        createButton('Consulta de Resultados', Icons.list, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultsScreen()),
          );
        }),
      ],
    );
  }

  Widget createButton(String text, IconData icon, VoidCallback onPress) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15), // Agrega padding vertical
        decoration: BoxDecoration(
          color: Colors.purple[100], // Botones con fondo lila claro
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.purple[800]), // Añade el icono al botón
            SizedBox(height: 5), // Espacio entre el icono y el texto
            Text(
              text,
              style: TextStyle(
                color: Colors.purple[800], // Texto en color lila oscuro
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomClipperHalf extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
