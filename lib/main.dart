import 'package:flutter/material.dart';
import 'componentes/jogo_da_velha.dart'; // Verifique se esse arquivo existe

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const String titulo = 'Jogo da Velha';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: titulo,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Jogo da Velha'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Alinhamento centralizado
          children: [
            // Centraliza o Jogo da Velha
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 234, 138, 205),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 7,
                    offset: Offset(5, 10),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: SizedBox.expand( // Garantir que o JogoDaVelha ocupe todo o espaço disponível
                  child: JogoDaVelha(), // Certifique-se de que o widget JogoDaVelha está funcionando
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
