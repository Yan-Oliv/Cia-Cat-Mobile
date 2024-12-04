import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'form_consultas.dart';
import 'package:flutter/material.dart';

import '../mensagens.dart'; // Tela de Mensagens
import '../manifesto.dart'; // Tela de Manifesto
import '../carregamento.dart'; // Tela de Carregamento
import '../home_screen.dart';

// Classe Consulta que estava faltando na sua tela
class Consulta {
  final int id;
  final String motorista;
  final String destino;
  final String buony;
  final String consulta;
  final String tipo;
  final String filial;

  // Construtor
  Consulta({
    required this.id,
    required this.motorista,
    required this.destino,
    required this.buony,
    required this.consulta,
    required this.tipo,
    required this.filial,
  });

  // Método para mapear os dados do JSON para o objeto Consulta
  factory Consulta.fromMap(Map<String, dynamic> map) {
    return Consulta(
        id: map['id'] ?? 0,
        motorista: map['motorista'] ?? "",
        destino: map['destino'] ?? "",
        buony: map['buony'] ?? "",
        consulta: map['consulta'] ?? "",
        tipo: map['tipo'] ?? "",
        filial: map['filial'] ?? "");
  }

  // Converte para JSON, incluindo o ID
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'motorista': motorista,
      'buony': buony,
      'consulta': consulta,
      'destino': destino,
      'tipo': tipo,
      'filial': filial,
    };
  }

  // Converte para JSON, sem incluir o ID (para PUT)
  Map<String, dynamic> toMapWithoutId() {
    return {
      'motorista': motorista,
      'buony': buony,
      'consulta': consulta,
      'destino': destino,
      'tipo': tipo,
      'filial': filial,
    };
  }
}

class ConsultasBuonny extends StatefulWidget {
  const ConsultasBuonny({super.key});

  @override
  ConsultasBuonnyState createState() => ConsultasBuonnyState();
}

class ConsultasBuonnyState extends State<ConsultasBuonny> {
  List<Consulta> consultas = [];

  final String apiUrl =
      'https://api-laravel-production-7674.up.railway.app/api/consultas';

  // Remover o getter http que estava incorreto
  // Não é necessário definir esse getter `http`, pois a biblioteca http já está importada corretamente

  @override
  void initState() {
    super.initState();
    loadConsultas();
  }

  loadConsultas() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          consultas = data
              .map((e) => Consulta.fromMap(Map<String, dynamic>.from(e)))
              .toList();
        });
      } else {
        _showErrorSnackBar(
            'Erro ao carregar as consultas: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorSnackBar('Erro de conexão: $e');
    }
  }

  _deleteConsulta(int id) async {
    try {
      // Formata a URL corretamente com o ID
      final response = await http.delete(
        Uri.parse('$apiUrl/$id'), // Remove a barra extra no final
      );

      if (response.statusCode == 200) {
        setState(() {
          consultas.removeWhere((consulta) => consulta.id == id);
        });
        _showErrorSnackBar('Consulta excluída com sucesso!');
      } else {
        _showErrorSnackBar('Erro ao excluir consulta: ${response.body}');
      }
    } catch (e) {
      _showErrorSnackBar('Erro de conexão: $e');
    }
  }

  void _copyToClipboard(Consulta consulta) {
    final consultaTexto = '''
*MOTORISTA:* ${consulta.motorista}
*BUONNY:* ${consulta.buony}
*CONSULTA:* ${consulta.consulta}
*DESTINO:* ${consulta.destino}
        ''';

    Clipboard.setData(ClipboardData(text: consultaTexto)).then((_) {
      _showErrorSnackBar('Consulta copiada para a área de transferência!');
    });
  }

  _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consultas',
          style: TextStyle(color: Colors.white), // Define o texto como branco
        ),
        backgroundColor: Colors.black, // Define o fundo como preto
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.list_alt), // Ícone para "Consultas Buonny"
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
              leading: const Icon(Icons.chat_bubble), // Ícone para "Mensagens"
              title: const Text('Mensagens'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Mensagens()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment), // Ícone para "Manifesto"
              title: const Text('Manifesto'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Manifesto()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.drive_eta), // Ícone para "Carregamento"
              title: const Text('Carregamento'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Carregamento()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: consultas.length,
                itemBuilder: (context, index) {
                  final consulta = consultas[index];
                  return ListTile(
                    tileColor: getColor(consulta.buony),
                    title: Text(
                      consulta.motorista,
                      style:
                          const TextStyle(color: Colors.white), // Texto branco
                    ),
                    subtitle: Text(
                      'Destino: ${consulta.destino}\n${consulta.buony}',
                      style:
                          const TextStyle(color: Colors.white), // Texto branco
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            // Navegar para a tela de edição
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FormularioConsulta(consulta: consulta),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: () => _deleteConsulta(consulta.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.white),
                          onPressed: () => _copyToClipboard(
                              consulta), // Adicionando botão para copiar
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  // Navegar para a tela de adicionar nova consulta
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FormularioConsulta(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Função que define a cor com base no status Buonny
Color getColor(String buony) {
  switch (buony) {
    case "PERFIL ADEQUADO AO RISCO":
      return Colors.green;
    case "PERFIL DIVERGENTE":
      return Colors.red;
    case "PERFIL COM INSUFICIENCIA DE DADOS":
      return Colors.amber; // Hexadecimal #FFD700
    case "EM PESQUISA":
      return Colors.blue;
    case "CONSULTAR PROFISSIONAL":
      return Colors.orange;
    case "EXPIRADO":
      return Colors.grey; // lightgray
    case "AGUARDANDO CADASTRO":
      return Colors.purple;
    case "CONSULTA ENVIADA":
      return const Color(0xFF8B0000); // Hexadecimal #8B0000
    case "APROVADA (EM ESPERA)":
      return const Color(0xFF008080); // Hexadecimal #008080
    case "AGUARDANDO CONSULTA":
      return const Color(0xFF8A2BE2); // Hexadecimal #8A2BE2
    default:
      return const Color(0xFFFFE4C4); // Hexadecimal #FFE4C4
  }
}
