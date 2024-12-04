import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'consultas/consultas.dart'; // Tela de Consultas Buonny
import 'mensagens.dart'; // Tela de Mensagens
import 'manifesto.dart'; // Tela de Manifesto
import 'carregamento.dart'; // Tela de Carregamento

import 'dart:async';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String greeting = "Carregando saudação...";
  IconData greetingIcon = Icons.wb_sunny; // Ícone padrão inicial

  @override
  void initState() {
    super.initState();
    fetchGreeting();
  }

  Future<void> fetchGreeting() async {
    try {
      final response = await http
          .get(Uri.parse(
              'http://worldtimeapi.org/api/timezone/America/Sao_Paulo'))
          .timeout(
              const Duration(seconds: 5)); // Adiciona um timeout de 5 segundos

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Verifica a estrutura de dados retornada
        if (data['datetime'] == null || data['utc_offset'] == null) {
          throw const FormatException('Dados inválidos recebidos da API.');
        }

        final datetime = DateTime.parse(data['datetime']);
        final utcOffset = data['utc_offset']; // Exemplo: "-03:00"

        // Calcula o offset em horas e minutos
        final offsetHours = int.parse(utcOffset.substring(1, 3));
        final offsetMinutes = int.parse(utcOffset.substring(4, 6));
        final isNegativeOffset = utcOffset.startsWith('-');

        // Ajusta o horário com o offset
        final adjustedDatetime = datetime.add(Duration(
          hours: isNegativeOffset ? -offsetHours : offsetHours,
          minutes: isNegativeOffset ? -offsetMinutes : offsetMinutes,
        ));

        final hour = adjustedDatetime.hour;

        setState(() {
          if (hour >= 6 && hour < 12) {
            greeting = "Bom dia!";
            greetingIcon = Icons.wb_sunny;
          } else if (hour >= 12 && hour < 18) {
            greeting = "Boa tarde!";
            greetingIcon = Icons.wb_sunny_outlined;
          } else {
            greeting = "Boa noite!";
            greetingIcon = Icons.nightlight_round;
          }
        });
      } else {
        // Trata outros status HTTP
        setState(() {
          greeting = "Erro ao obter saudação. Status: ${response.statusCode}";
        });
      }
    } on FormatException catch (e) {
      setState(() {
        greeting = "Erro de formato nos dados recebidos.";
      });
      debugPrint("Erro de formato: $e");
    } on http.ClientException catch (e) {
      setState(() {
        greeting = "Erro de conexão com o servidor.";
      });
      debugPrint("Erro de conexão: $e");
    } on TimeoutException {
      setState(() {
        greeting = "Tempo de resposta da API excedido.";
      });
      debugPrint("Timeout ao conectar à API.");
    } catch (e) {
      setState(() {
        greeting = "Erro ao obter saudação.";
      });
      debugPrint("Erro inesperado: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Define o fundo como preto
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              greetingIcon,
              size: 28, // Tamanho do ícone
              color: Colors.white, // Cor do ícone
            ),
            const SizedBox(width: 8),
            Text(
              greeting,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Define a cor do texto como branca
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/caminhao.gif', // Coloque seu GIF na pasta 'assets' e defina isso no pubspec.yaml
              height: 150,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 248, 248, 248),
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Row(
            children: [
              Icon(Icons.local_shipping,
                  color: Colors.black), // Ícone de caminhão
              SizedBox(width: 8), // Espaço entre o ícone e o texto
              Text('Cia Cat System', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.list_alt),
                title: const Text('Consultas Buonny'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConsultasBuonny()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat_bubble),
                title: const Text('Mensagens'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Mensagens()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.assignment),
                title: const Text('Manifesto'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Manifesto()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.drive_eta),
                title: const Text('Carregamento'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Carregamento()),
                  );
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: const MiniGameScreen());
  }
}

class MiniGameScreen extends StatefulWidget {
  const MiniGameScreen({super.key});

  @override
  MiniGameScreenState createState() => MiniGameScreenState();
}

class MiniGameScreenState extends State<MiniGameScreen> {
  static const int rows = 20; // Linhas do tabuleiro
  static const int cols = 10; // Colunas do tabuleiro
  List<List<int>> board = List.generate(rows, (_) => List.filled(cols, 0));
  List<List<int>> currentPiece = [];
  int currentPieceRow = 0;
  int currentPieceCol = cols ~/ 2 - 1;
  bool gameOver = false;
  late Timer gameTimer;

  final List<List<List<int>>> tetrominoes = [
    // Formas das peças
    [
      [1, 1],
      [1, 1],
    ], // Quadrado
    [
      [0, 1, 0],
      [1, 1, 1],
    ], // T
    [
      [1, 1, 0],
      [0, 1, 1],
    ], // Z
    [
      [0, 1, 1],
      [1, 1, 0],
    ], // S
    [
      [1],
      [1],
      [1],
      [1],
    ], // Linha
  ];

  @override
  void initState() {
    super.initState();
    _spawnPiece();
    gameTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!gameOver) {
        _moveDown();
      }
    });
  }

  @override
  void dispose() {
    gameTimer.cancel();
    super.dispose();
  }

  void _spawnPiece() {
    final random = Random();
    currentPiece = tetrominoes[random.nextInt(tetrominoes.length)];
    currentPieceRow = 0;
    currentPieceCol = cols ~/ 2 - currentPiece[0].length ~/ 2;
    if (_checkCollision(currentPieceRow, currentPieceCol)) {
      setState(() {
        gameOver = true;
      });
    }
  }

  bool _checkCollision(int row, int col) {
    for (int i = 0; i < currentPiece.length; i++) {
      for (int j = 0; j < currentPiece[i].length; j++) {
        if (currentPiece[i][j] == 1) {
          int boardRow = row + i;
          int boardCol = col + j;
          if (boardRow >= rows ||
              boardCol < 0 ||
              boardCol >= cols ||
              board[boardRow][boardCol] == 1) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void _placePiece() {
    for (int i = 0; i < currentPiece.length; i++) {
      for (int j = 0; j < currentPiece[i].length; j++) {
        if (currentPiece[i][j] == 1) {
          board[currentPieceRow + i][currentPieceCol + j] = 1;
        }
      }
    }
    _clearLines();
    _spawnPiece();
  }

  void _clearLines() {
    setState(() {
      board.removeWhere((row) => row.every((cell) => cell == 1));
      while (board.length < rows) {
        board.insert(0, List.filled(cols, 0));
      }
    });
  }

  void _moveDown() {
    if (!_checkCollision(currentPieceRow + 1, currentPieceCol)) {
      setState(() {
        currentPieceRow++;
      });
    } else {
      _placePiece();
    }
  }

  void _moveLeft() {
    if (!_checkCollision(currentPieceRow, currentPieceCol - 1)) {
      setState(() {
        currentPieceCol--;
      });
    }
  }

  void _moveRight() {
    if (!_checkCollision(currentPieceRow, currentPieceCol + 1)) {
      setState(() {
        currentPieceCol++;
      });
    }
  }

  void _rotatePiece() {
    final rotatedPiece = List.generate(
      currentPiece[0].length,
      (i) => List.generate(currentPiece.length,
          (j) => currentPiece[currentPiece.length - j - 1][i]),
    );
    if (!_checkCollision(currentPieceRow, currentPieceCol)) {
      setState(() {
        currentPiece = rotatedPiece;
      });
    }
  }

  void _resetGame() {
    setState(() {
      board = List.generate(rows, (_) => List.filled(cols, 0));
      currentPiece = [];
      currentPieceRow = 0;
      currentPieceCol = cols ~/ 2 - 1;
      gameOver = false;
    });
    _spawnPiece(); // Inicia uma nova peça
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
            ),
            itemCount: rows * cols,
            itemBuilder: (context, index) {
              int x = index % cols;
              int y = index ~/ cols;
              bool isPiece = false;
              for (int i = 0; i < currentPiece.length; i++) {
                for (int j = 0; j < currentPiece[i].length; j++) {
                  if (currentPiece[i][j] == 1 &&
                      currentPieceRow + i == y &&
                      currentPieceCol + j == x) {
                    isPiece = true;
                    break;
                  }
                }
              }
              return Container(
                margin: const EdgeInsets.all(1),
                color: board[y][x] == 1 || isPiece
                    ? Colors.blue
                    : Colors.grey[900],
              );
            },
          ),
          if (gameOver)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Game Over',
                    style: TextStyle(color: Colors.red, fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _resetGame,
                    child: const Text('Reiniciar'),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _rotatePiece,
            child: const Icon(Icons.rotate_right),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _moveLeft,
            child: const Icon(Icons.arrow_left),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _moveRight,
            child: const Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}
