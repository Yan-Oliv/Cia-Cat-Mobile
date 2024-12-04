import 'package:ciacat_notlog/screens/consultas/consultas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para manipulação da área de transferência
import 'mensagens.dart'; // Tela de Mensagens
import 'home_screen.dart';
import 'manifesto.dart';

class Carregamento extends StatefulWidget {
  const Carregamento({super.key});

  @override
  CarregamentoState createState() => CarregamentoState();
}

class CarregamentoState extends State<Carregamento> {
  // Controladores de texto para os campos
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _cargaController = TextEditingController();
  final TextEditingController _motoristaController = TextEditingController();
  final TextEditingController _placaCavaloController = TextEditingController();
  final TextEditingController _placaCarretaController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _previsaoController = TextEditingController();

  String _empresa = 'TMRC'; // Empresa selecionada

  // Função para formatar o CPF
  String _formatCpf(String cpf) {
    final digitsOnly = cpf.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length > 11) {
      return digitsOnly.substring(0, 11);
    }
    return digitsOnly;
  }

  // Função para formatar telefone
  String _formatTelefone(String telefone) {
    final digitsOnly = telefone.replaceAll(
        RegExp(r'\D'), ''); // Remove todos os caracteres não numéricos
    if (digitsOnly.length > 11) {
      return digitsOnly.substring(0, 11); // Limita o tamanho para 11 dígitos
    }

    if (digitsOnly.length <= 2) {
      return '($digitsOnly)'; // Formata para "(XX"
    } else if (digitsOnly.length <= 6) {
      return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2)}'; // Formata para "(XX) XXXX"
    } else {
      return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 7)}-${digitsOnly.substring(7, 11)}'; // Formata para "(XX) XXXX-XXXX"
    }
  }

  // Função para enviar o formulário
  void _sendForm() {
    String cliente = "CCM";
    String destino = _destinoController.text;
    String carga = _cargaController.text;
    String motorista = _motoristaController.text;
    String placaCavalo = _placaCavaloController.text;
    String placaCarreta = _placaCarretaController.text;
    String cpf = _formatCpf(_cpfController.text);
    String telefone = _formatTelefone(_telefoneController.text);
    String previsao = _previsaoController.text;

    String mensagem = _empresa == "TMRC"
        ? "*TMRC TRANSPORTES:*\nCARREGAMENTO\n\n*CLIENTE:* $cliente\n*DESTINO:* $destino\n*CARGA:* $carga\n*MOTORISTA:* $motorista\n*PLACA CAVALO:* $placaCavalo\n*PLACA CARRETA:* $placaCarreta\n*CPF:* $cpf\n*FONE:* $telefone\n*PREVISÃO DE CHEGADA:* $previsao"
        : "*CIA CARGAS:*\nCARREGAMENTO\n\n*CLIENTE:* $cliente\n*DESTINO:* $destino\n*CARGA:* $carga\n*MOTORISTA:* $motorista\n*PLACA CAVALO:* $placaCavalo\n*PLACA CARRETA:* $placaCarreta\n*CPF:* $cpf\n*FONE:* $telefone\n*PREVISÃO DE CHEGADA:* $previsao";

    // Copiar para a área de transferência
    Clipboard.setData(ClipboardData(text: mensagem)).then((_) {
      if (mounted) {
        // Exibir mensagem informando que o texto foi copiado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Mensagem copiada para a área de transferência!')),
        );
      }
    });
  }

  // Função para limpar os campos
  void _clearForm() {
    _destinoController.clear();
    _cargaController.clear();
    _motoristaController.clear();
    _placaCavaloController.clear();
    _placaCarretaController.clear();
    _cpfController.clear();
    _telefoneController.clear();
    _previsaoController.clear();
  }

  // Função para quando o CPF perde o foco
  void onCpfEditingComplete() {
    final formattedCpf = _formatCpf(_cpfController.text);
    _cpfController.text = formattedCpf;
  }

  // Função para quando o Telefone perde o foco
  void onTelefoneEditingComplete() {
    final formattedTelefone = _formatTelefone(_telefoneController.text);
    _telefoneController.text = formattedTelefone;
  }

  // Função para transformar o texto em maiúsculas
  TextInputFormatter _upperCaseFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String newText = newValue.text.toUpperCase();
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carregamento',
          style: TextStyle(color: Colors.white), // Define o texto como branco
        ),
        backgroundColor: Colors.black,
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
        child: SingleChildScrollView(
          // Adicionando Scroll
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Empresa (Radio Buttons)
              Row(
                children: [
                  const Text('Empresa:'),
                  Radio<String>(
                    value: 'TMRC',
                    groupValue: _empresa,
                    onChanged: (value) {
                      setState(() {
                        _empresa = value!;
                      });
                    },
                  ),
                  const Text('TMRC'),
                  Radio<String>(
                    value: 'CCM',
                    groupValue: _empresa,
                    onChanged: (value) {
                      setState(() {
                        _empresa = value!;
                      });
                    },
                  ),
                  const Text('CCM'),
                ],
              ),
              const SizedBox(height: 10),
              // Destino
              TextField(
                controller: _destinoController,
                decoration: const InputDecoration(labelText: 'Destino'),
                inputFormatters: [_upperCaseFormatter()],
              ),
              const SizedBox(height: 10),
              // Carga
              TextField(
                controller: _cargaController,
                decoration: const InputDecoration(labelText: 'Carga'),
                inputFormatters: [_upperCaseFormatter()],
              ),
              const SizedBox(height: 10),
              // Motorista
              TextField(
                controller: _motoristaController,
                decoration: const InputDecoration(labelText: 'Motorista'),
                inputFormatters: [_upperCaseFormatter()],
              ),
              const SizedBox(height: 10),
              // Placa Cavalo
              TextField(
                controller: _placaCavaloController,
                decoration: const InputDecoration(labelText: 'Placa Cavalo'),
                inputFormatters: [_upperCaseFormatter()],
              ),
              const SizedBox(height: 10),
              // Placa Carreta
              TextField(
                controller: _placaCarretaController,
                decoration: const InputDecoration(labelText: 'Placa Carreta'),
                inputFormatters: [_upperCaseFormatter()],
              ),
              const SizedBox(height: 10),
              // CPF com formatação automática enquanto digita
              TextField(
                controller: _cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  CpfInputFormatter()
                ], // Adicione esse formatter
              ),
              const SizedBox(height: 10),
              // Telefone
              TextField(
                controller: _telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  TelefoneInputFormatter() // Adicionando o formatter
                ],
                onEditingComplete: onTelefoneEditingComplete,
              ),
              const SizedBox(height: 10),
              // Previsão de Chegada
              TextField(
                controller: _previsaoController,
                decoration:
                    const InputDecoration(labelText: 'Previsão de Chegada'),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 20),
              // Botões de Ação
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _clearForm,
                    child: const Text('Limpar'),
                  ),
                  ElevatedButton(
                    onPressed: _sendForm,
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text
        .replaceAll(RegExp(r'\D'), ''); // Remove qualquer não-dígito

    // Limita a 11 caracteres (CPF com 11 dígitos)
    if (newText.length > 11) {
      newText = newText.substring(0, 11);
    }

    // Aplica a formatação do CPF
    if (newText.length >= 3 && newText.length <= 5) {
      newText = '${newText.substring(0, 3)}.${newText.substring(3)}';
    } else if (newText.length >= 6 && newText.length <= 8) {
      newText =
          '${newText.substring(0, 3)}.${newText.substring(3, 6)}.${newText.substring(6)}';
    } else if (newText.length >= 9) {
      newText =
          '${newText.substring(0, 3)}.${newText.substring(3, 6)}.${newText.substring(6, 9)}-${newText.substring(9)}';
    }

    // Retorna o valor formatado com a posição do cursor ajustada
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class TelefoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(
        RegExp(r'\D'), ''); // Remove todos os caracteres não numéricos

    // Limita o número de dígitos a 11
    if (newText.length > 11) {
      newText = newText.substring(0, 11);
    }

    // Aplica a formatação para "(XX) XXXX-XXXX"
    if (newText.length >= 2 && newText.length <= 3) {
      newText = '(${newText.substring(0, 2)}) ${newText.substring(2)}';
    } else if (newText.length >= 4 && newText.length <= 6) {
      newText = '(${newText.substring(0, 2)}) ${newText.substring(2, 6)}';
    } else if (newText.length > 6) {
      newText =
          '(${newText.substring(0, 2)}) ${newText.substring(2, 7)}-${newText.substring(7, 11)}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
