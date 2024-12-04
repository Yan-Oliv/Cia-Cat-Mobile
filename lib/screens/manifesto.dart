import 'package:ciacat_notlog/screens/consultas/consultas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mensagens.dart'; // Tela de Mensagens
import 'carregamento.dart'; // Tela de Carregamento
import 'home_screen.dart';

void main() {
  runApp(const Manifesto());
}

class Manifesto extends StatelessWidget {
  const Manifesto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cia Cat System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ManifestoForm(),
    );
  }
}

class ManifestoForm extends StatefulWidget {
  const ManifestoForm({super.key});

  @override
  ManifestoFormState createState() => ManifestoFormState();
}

class ManifestoFormState extends State<ManifestoForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _filialController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _motoristaController = TextEditingController();
  final TextEditingController _placaCavaloController = TextEditingController();
  final TextEditingController _placaCarretaController = TextEditingController();
  final TextEditingController _obsCteController = TextEditingController();
  final TextEditingController _valorAcordadoController =
      TextEditingController();
  final TextEditingController _porcentagemAdiantamentoController =
      TextEditingController();
  final TextEditingController _tipoEntregaController = TextEditingController();
  final TextEditingController _rotaController = TextEditingController();
  final TextEditingController _tagPedagioController = TextEditingController();
  final TextEditingController _responsavelController = TextEditingController();
  final TextEditingController _bancoController = TextEditingController();
  final TextEditingController _agenciaController = TextEditingController();
  final TextEditingController _contaController = TextEditingController();
  final TextEditingController _tipoChavePixController = TextEditingController();
  final TextEditingController _chavePixController = TextEditingController();
  final TextEditingController _favorecidoController = TextEditingController();

  final FocusNode _valorAcordadoFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Adiciona listener ao FocusNode
    _valorAcordadoFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _valorAcordadoFocusNode.removeListener(_onFocusChange);
    _valorAcordadoFocusNode.dispose();
    super.dispose();
  }

  // Função para aplicar a formatação de moeda
  void _onFocusChange() {
    if (!_valorAcordadoFocusNode.hasFocus) {
      // Formata o valor de acordo com o que foi digitado, apenas quando o campo perde o foco
      _valorAcordadoController.text = CurrencyTextInputFormatter()
          .formatEditUpdate(
            TextEditingValue(text: _valorAcordadoController.text),
            TextEditingValue(text: _valorAcordadoController.text),
          )
          .text;
    }
  }

  String? _clienteSelecionado;
  String? _tipoChavePixSelecionado;
  String _tipoVeiculo = 'CARRETA';
  bool _placaCarretaDesabilitada = false;

  final List<String> _clientes = [
    "PLATINA",
    "CCM",
    "TMRC",
    "ECOMASTER",
    "WHIRLPOOL",
    "BRITVIC",
    "MERCOQUIMICA",
    "UNICHARM",
    "YPE",
    "MRV",
    "BRASWELL",
    "BASTON",
    "MAIS POLIMEROS",
    "CARGOPLACE",
    "CJ BRASIL",
    "DEHEUS",
    "BMAGALHAES",
    "FOB",
    "OJI",
    "PLACAS DO BRASIL",
    "WESTROCK",
    "JMACEDO"
  ];

  final List<String> _tiposChavePix = [
    "CPF",
    "CNPJ",
    "TELEFONE",
    "E-MAIL",
    "CHAVE ALEATÓRIA"
  ];

  void _copyToClipboard() {
    final manifesto = {
      'cliente': _clienteController.text,
      'filial': _filialController.text,
      'destino': _destinoController.text,
      'motorista': _motoristaController.text,
      'tipo_veiculo': _tipoVeiculo,
      'placa_cavalo': _placaCavaloController.text,
      'placa_carreta': _placaCarretaController.text,
      'obs_cte': _obsCteController.text,
      'valor_acordado': _valorAcordadoController.text,
      'porcentagem_adiantamento': _porcentagemAdiantamentoController.text,
      'tipo_entrega': _tipoEntregaController.text,
      'rota': _rotaController.text,
      'tag_vale_pedagio': _tagPedagioController.text.isEmpty
          ? 'SEM TAG'
          : _tagPedagioController.text,
      'responsavel': _responsavelController.text,
      'banco': _bancoController.text.isEmpty ? 'N/A' : _bancoController.text,
      'agencia':
          _agenciaController.text.isEmpty ? 'N/A' : _agenciaController.text,
      'conta': _contaController.text.isEmpty ? 'N/A' : _contaController.text,
      'tipo_chave_pix': _tipoChavePixController.text,
      'chave_pix': _chavePixController.text,
      'favorecido': _favorecidoController.text,
    };

    final manifestoFormatted = """
*CIA CARGAS:*
*CTE / MANIFESTO*

*CLIENTE:* ${manifesto['cliente']}
*FILIAL:* ${manifesto['filial']}
*TOMADOR DO SERVIÇO:* ${manifesto['cliente']}
*DESTINO:* ${manifesto['destino']}
*MOTORISTA:* ${manifesto['motorista']}
*TIPO DE VEICULO:* ${manifesto['tipo_veiculo']}
*PLACA CAVALO:* ${manifesto['placa_cavalo']}
*PLACA CARRETA:* ${manifesto['placa_carreta']?.isEmpty ?? true ? 'N/A' : manifesto['placa_carreta']}
*OBSERVAÇÃO CTE:* ${manifesto['obs_cte']}
*TABELA DE FRETE:*
*VALOR ACORDADO:* ${manifesto['valor_acordado']}
*PORCENTAGEM DE ADIANTAMENTO:* ${manifesto['porcentagem_adiantamento']}
*DATA DE COLETA:*
*DATA DA ENTREGA:*
*TIPO DE ENTREGA:* ${manifesto['tipo_entrega']}
*ROTA:* ${manifesto['rota']}
*TAG VALE PEDÁGIO:* ${manifesto['tag_vale_pedagio']}
*RESPONSAVEL:* ${manifesto['responsavel']}
*DESCONTO:* R\$ BUONNY
*DADOS BANCARIOS:*
BANCO ${manifesto['banco']}
AGÊNCIA: ${manifesto['agencia']}
C/C: ${manifesto['conta']}
CHAVE PIX ${manifesto['tipo_chave_pix']}: ${manifesto['chave_pix']}
FAVORECIDO: ${manifesto['favorecido']}
""";

    Clipboard.setData(ClipboardData(text: manifestoFormatted));

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("Manifesto copiado para a área de transferência!")),
    );
  }

  void _limparFormulario() {
    _formKey.currentState?.reset();
    setState(() {
      _clienteController.clear();
      _filialController.clear();
      _destinoController.clear();
      _motoristaController.clear();
      _placaCavaloController.clear();
      _placaCarretaController.clear();
      _obsCteController.clear();
      _valorAcordadoController.clear();
      _porcentagemAdiantamentoController.clear();
      _tipoEntregaController.clear();
      _rotaController.clear();
      _tagPedagioController.clear();
      _responsavelController.clear();
      _bancoController.clear();
      _agenciaController.clear();
      _contaController.clear();
      _tipoChavePixController.clear();
      _chavePixController.clear();
      _favorecidoController.clear();
      _placaCarretaDesabilitada = false;
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _clienteSelecionado,
                hint: const Text("Selecione o Cliente"),
                onChanged: (value) {
                  setState(() {
                    _clienteSelecionado = value;
                    _clienteController.text = value!;
                  });
                },
                items: _clientes.map((cliente) {
                  return DropdownMenuItem<String>(
                    value: cliente,
                    child: Text(cliente),
                  );
                }).toList(),
              ),
              _buildTextField("Filial", _filialController,
                  inputFormatters: [UpperCaseTextFormatter()]),
              _buildTextField("Destino", _destinoController,
                  inputFormatters: [UpperCaseTextFormatter()]),
              _buildTextField("Motorista", _motoristaController,
                  inputFormatters: [UpperCaseTextFormatter()]),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("Tipo de Veículo: "),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'CARRETA',
                        groupValue: _tipoVeiculo,
                        onChanged: (value) {
                          setState(() {
                            _tipoVeiculo = value!;
                            _placaCarretaDesabilitada = false;
                          });
                        },
                      ),
                      const Text("CARRETA"),
                      Radio<String>(
                        value: 'TRUCK',
                        groupValue: _tipoVeiculo,
                        onChanged: (value) {
                          setState(() {
                            _tipoVeiculo = value!;
                            _placaCarretaDesabilitada = true;
                          });
                        },
                      ),
                      const Text("TRUCK"),
                    ],
                  ),
                ],
              ),
              _buildTextField("Placa Cavalo", _placaCavaloController,
                  inputFormatters: [UpperCaseTextFormatter()]),
              _buildTextField("Placa Carreta", _placaCarretaController,
                  enabled: !_placaCarretaDesabilitada,
                  inputFormatters: [UpperCaseTextFormatter()]),
              _buildTextField("Observação CTE", _obsCteController,
                  inputFormatters: [UpperCaseTextFormatter()]),
              TextFormField(
                controller: _valorAcordadoController,
                focusNode: _valorAcordadoFocusNode,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Valor Acordado'),
              ),
              _buildTextField(
                "Porcentagem Adiantamento",
                _porcentagemAdiantamentoController,
                inputFormatters: [PercentTextInputFormatter()],
              ),
              _buildTextField("Tipo de Entrega", _tipoEntregaController,
                  inputFormatters: [UpperCaseTextFormatter()]),
              _buildTextField("Rota", _rotaController,
                  inputFormatters: [UpperCaseTextFormatter()]),
              _buildTextField("TAG Vale Pedágio", _tagPedagioController,
                  inputFormatters: [UpperCaseTextFormatter()]),
              _buildTextField("Responsável", _responsavelController,
                  inputFormatters: [UpperCaseTextFormatter()]),
              _buildTextField("Banco", _bancoController,
                  inputFormatters: [UpperCaseTextFormatter()]),
              _buildTextField("Agência", _agenciaController),
              _buildTextField("Conta", _contaController),
              DropdownButtonFormField<String>(
                value: _tipoChavePixSelecionado,
                hint: const Text("Selecione o Tipo de Chave PIX"),
                onChanged: (value) {
                  setState(() {
                    _tipoChavePixSelecionado = value;
                    _tipoChavePixController.text = value!;
                  });
                },
                items: _tiposChavePix.map((tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo,
                    child: Text(tipo),
                  );
                }).toList(),
              ),
              _buildTextField("Chave PIX", _chavePixController),
              _buildTextField("Favorecido", _favorecidoController,
                  inputFormatters: [UpperCaseTextFormatter()]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _copyToClipboard,
                    child: const Text('Enviar 📬'),
                  ),
                  const SizedBox(width: 10), // Espaço entre os botões
                  ElevatedButton(
                    onPressed: _limparFormulario,
                    child: const Text('Limpar 🧹'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildTextField(
    String label,
    TextEditingController controller, {
    bool enabled = true,
    List<TextInputFormatter>? inputFormatters,
    FocusNode? focusNode,
    ValueChanged<String>? onFieldSubmitted,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Transforma o texto digitado em maiúsculas
    String newText = newValue.text.toUpperCase();

    // Retorna a alteração no formato de texto com a seleção do cursor
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

// Função para formatar o valor como moeda
class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove tudo o que não for número
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isEmpty) {
      return const TextEditingValue(text: 'R\$ 0,00');
    }

    // Se o número tiver menos de 3 caracteres, considera como centavos
    if (newText.length <= 2) {
      newText =
          newText.padLeft(2, '0'); // Adiciona zeros à esquerda se necessário
      return TextEditingValue(
        text: 'R\$ 0,$newText',
        selection: TextSelection.collapsed(offset: newText.length + 3),
      );
    }

    // Caso tenha 3 ou mais caracteres, divide em parte inteira e decimal
    String integerPart =
        newText.substring(0, newText.length - 2); // Parte inteira
    String decimalPart = newText.substring(newText.length - 2); // Parte decimal

    // Formata a parte inteira com separadores de milhar
    final integerFormatted = integerPart.replaceAllMapped(
        RegExp(r"(\d)(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]}.");

    // Junta a parte inteira e a parte decimal
    newText = "$integerFormatted,$decimalPart";

    return TextEditingValue(
      text: 'R\$ $newText',
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class PercentTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove tudo o que não for número
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isEmpty) {
      return const TextEditingValue(text: '0%');
    }

    // Limita o valor máximo de porcentagem (exemplo: 100%)
    if (newText.length > 3) {
      newText = newText.substring(0, 3); // Limita a 3 dígitos
    }

    // Adiciona o caractere '%' ao final
    newText = "$newText%";

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
