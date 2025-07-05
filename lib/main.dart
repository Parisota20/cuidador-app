import 'package:flutter/material.dart';

void main() {
  runApp(CuidadorApp());
}

class CuidadorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evaluación del Cuidador',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: InstruccionesScreen(),
    );
  }
}

class InstruccionesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Instrucciones")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "A continuación se presenta una lista de afirmaciones, en las cuales se refleja cómo se sienten, a veces, las personas que cuidan a otra persona.\n\n"
              "Después de leer cada afirmación, debe indicar con qué frecuencia se siente usted así:\n\n"
              "0. nunca\n1. raramente\n2. algunas veces\n3. bastante veces\n4. casi siempre",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreguntasScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                backgroundColor: Colors.teal,
              ),
              child: Text(
                "Comenzar",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreguntasScreen extends StatefulWidget {
  @override
  _PreguntasScreenState createState() => _PreguntasScreenState();
}

class _PreguntasScreenState extends State<PreguntasScreen> {
  int preguntaActual = 0;
  List<int?> respuestas = [];

  final List<String> preguntas = [
    "¿Piensa que su familiar le pide más ayuda de la que realmente necesita?",
    "¿Piensa que debido al tiempo que dedica a su familiar no tiene suficiente tiempo para usted?",
    "¿Se siente agobiado por intentar compatibilizar el cuidado de su familiar con otras responsabilidades (trabajo, familia)?",
    "¿Siente vergüenza por la conducta de su familiar?",
    "¿Se siente enfadado cuando está cerca de su familiar?",
    "¿Piensa que el cuidar de su familiar afecta negativamente la relación con otros miembros de su familia?",
    "¿Tiene miedo por el futuro de su familiar?",
    "¿Piensa que su familiar depende de usted?",
    "¿Se siente tenso cuando está cerca de su familiar?",
    "¿Piensa que su salud ha empeorado debido al cuidado de su familiar?",
    "¿Piensa que no tiene tanta intimidad como quisiera por cuidar a su familiar?",
    "¿Su vida social se ha visto afectada negativamente por cuidar a su familiar?",
    "¿Se siente incómodo por distanciarse de sus amistades debido al cuidado de su familiar?",
    "¿Piensa que su familiar lo considera la única persona que puede cuidarle?",
    "¿Cree que no tiene ingresos suficientes para los gastos de cuidar a su familiar?",
    "¿Piensa que no podrá cuidar a su familiar mucho más tiempo?",
    "¿Siente que ha perdido el control de su vida desde que comenzó la enfermedad de su familiar?",
    "¿Desearía poder dejar el cuidado de su familiar a otra persona?",
    "¿Se siente indeciso sobre qué hacer con su familiar?",
    "¿Piensa que debería hacer más por su familiar?",
    "¿Cree que podría cuidar mejor a su familiar?",
    "Globalmente, ¿qué grado de 'carga' experimenta al cuidar a su familiar?",
  ];

  void responder(int valor) {
    setState(() {
      respuestas.add(valor);
      if (preguntaActual < preguntas.length - 1) {
        preguntaActual++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FinalScreen(respuestas),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cuestionario del Cuidador"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Pregunta ${preguntaActual + 1} de ${preguntas.length}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Text(
              preguntas[preguntaActual],
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            for (int i = 0; i <= 4; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => responder(i),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.teal.shade600,
                  ),
                  child: Text(
                    "$i",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FinalScreen extends StatelessWidget {
  final List<int?> respuestas;

  FinalScreen(this.respuestas);

  String interpretarPuntaje(int total) {
    if (total < 47) {
      return 'No se encuentra en sobrecarga.';
    } else if (total <= 55) {
      return 'Sobrecarga leve.';
    } else {
      return 'Sobrecarga intensa.';
    }
  }

  @override
  Widget build(BuildContext context) {
    int total = respuestas.fold(0, (a, b) => a! + b!);
    String interpretacion = interpretarPuntaje(total);

    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado del Cuestionario"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Su puntuación total es: $total",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              "Interpretación del resultado:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "- Menor de 47: no se encuentra en sobrecarga\n"
              "- Entre 47 y 55: sobrecarga leve\n"
              "- Mayor de 55: sobrecarga intensa",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Text(
              "Resultado: $interpretacion",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}