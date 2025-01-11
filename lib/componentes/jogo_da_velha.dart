// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: JogoDaVelha()));
}

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({super.key});

  @override
  _JogoDaVelhaState createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> _tabuleiro = List.filled(9, ''); // Estado do tabuleiro
  String _jogador = 'X'; // Jogador atual ('X' ou 'O')
  String _mensagem = ''; // Mensagem de vencedor ou empate
  final bool _contraMaquina = false; // Se o jogo é contra a máquina

  // Função para trocar o jogador
  void _trocaJogador() {
    setState(() {
      _jogador = (_jogador == 'X') ? 'O' : 'X';
    });
  }

  // Função para verificar o vencedor
  bool _verificarVencedor(String jogador) {
    // Verificar as linhas, colunas e diagonais
    List<List<int>> combinacoes = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Linhas
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Colunas
      [0, 4, 8], [2, 4, 6], // Diagonais
    ];

    for (var combinacao in combinacoes) {
      if (_tabuleiro[combinacao[0]] == jogador &&
          _tabuleiro[combinacao[1]] == jogador &&
          _tabuleiro[combinacao[2]] == jogador) {
        setState(() {
          _mensagem = '$jogador venceu!';
        });
        return true;
      }
    }

    // Verificar se houve empate
    if (!_tabuleiro.contains('')) {
      setState(() {
        _mensagem = 'Empate!';
      });
    }
    return false;
  }

  // Função para jogada do jogador
  void _jogada(int index) {
    if (_tabuleiro[index] == '' && _mensagem == '') {
      setState(() {
        _tabuleiro[index] = _jogador;
      });

      // Verificar vencedor após a jogada
      if (!_verificarVencedor(_jogador)) {
        _trocaJogador(); // Troca o jogador após a jogada
        if (_contraMaquina && _jogador == 'O') {
          _jogadaComputador(); // Se for contra a máquina, a máquina joga
        }
      }
    }
  }

  // Função para a jogada da máquina (IA simples)
  void _jogadaComputador() {
    int indexLivre = _tabuleiro.indexOf('');
    if (indexLivre != -1) {
      _jogada(indexLivre); // A máquina preenche a próxima célula livre
    }
  }

  // Função para reiniciar o jogo
  void reiniciarJogo() {
    setState(() {
      _tabuleiro = List.filled(9, ''); // Limpa o tabuleiro
      _mensagem = ''; // Limpa a mensagem
      _jogador = 'X'; // Inicia com o jogador X
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Exibir a mensagem de vencedor ou empate
          if (_mensagem.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _mensagem,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          // Tabuleiro
          GridView.builder(
            shrinkWrap: true, // Permite que o GridView se ajuste ao espaço disponível
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _jogada(index), // Chama a função de jogada
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      _tabuleiro[index],
                      style: const TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          // Botão para reiniciar o jogo
          ElevatedButton(
            onPressed: reiniciarJogo,
            child: const Text('Reiniciar Jogo', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
