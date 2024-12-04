import 'dart:convert';
import 'package:ciacat_notlog/screens/consultas/consultas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormularioConsulta extends StatefulWidget {
  final Consulta? consulta; // Parâmetro opcional

  // Construtor
  const FormularioConsulta({super.key, this.consulta});

  @override
  FormularioConsultaState createState() => FormularioConsultaState();
}

class FormularioConsultaState extends State<FormularioConsulta> {
  late TextEditingController motoristaController;
  late TextEditingController destinoController;
  String? selectedBuonny;
  String? selectedConsulta;

  List<String> buonnyOptions = [
    "PERFIL ADEQUADO AO RISCO",
    "PERFIL DIVERGENTE",
    "PERFIL COM INSUFICIENCIA DE DADOS",
    "EM PESQUISA",
    "CONSULTAR PROFISSIONAL",
    "EXPIRADO",
    "AGUARDANDO CADASTRO",
    "AGUARDANDO CONSULTA",
    "CONSULTA ENVIADA",
    "APROVADA (EM ESPERA)"
  ];

  List<String> consultaOptions = ["SÓ CONSULTA", "COBRAR INTEGRAL"];

  final String apiUrl =
      'https://api-laravel-production-7674.up.railway.app/api/consultas';

  @override
  void initState() {
    super.initState();
    motoristaController = TextEditingController(
        text: widget.consulta?.motorista ?? '')
      ..addListener(_formatMotorista); // Adicionando o listener para formatação
    destinoController =
        TextEditingController(text: widget.consulta?.destino ?? '');
    selectedBuonny = widget.consulta?.buony;
    selectedConsulta = widget.consulta?.consulta;
  }

  _addOrUpdateConsulta() async {
    final isPost = widget.consulta == null; // Determina se é POST ou PUT

    final newConsulta = Consulta(
        id: widget.consulta?.id ?? 0, // Apenas usado internamente
        motorista: motoristaController.text.trim(),
        buony: selectedBuonny ?? '',
        consulta: selectedConsulta ?? '',
        destino: destinoController.text.trim(),
        tipo: '1', // Ajuste conforme necessário
        filial: 'Catalão');

    // Validação básica
    if (newConsulta.motorista.isEmpty ||
        newConsulta.destino.isEmpty ||
        newConsulta.tipo.isEmpty) {
      _showErrorSnackBar('Por favor, preencha todos os campos obrigatórios.');
      return;
    }

    try {
      final url = isPost
          ? Uri.parse(
              'https://api-laravel-production-7674.up.railway.app/api/consultas/')
          : Uri.parse(
              'https://api-laravel-production-7674.up.railway.app/api/consultas/${widget.consulta!.id}');

      // Converte o objeto para um mapa, removendo o ID em caso de PUT
      final body = json
          .encode(isPost ? newConsulta.toMap() : newConsulta.toMapWithoutId());

      final response = await (isPost
          ? http.post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: body,
            )
          : http.put(
              url,
              headers: {'Content-Type': 'application/json'},
              body: body,
            ));

      if (response.statusCode == 201 || response.statusCode == 200) {
        final consultasBuonnyState = ConsultasBuonnyState();
        consultasBuonnyState.loadConsultas();
        if (mounted) Navigator.pop(context);
      } else {
        _showErrorSnackBar(
            'Erro ao salvar consulta: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      _showErrorSnackBar('Erro de conexão: $e');
    }
  }

  _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Função para formatar automaticamente o texto para maiúsculas
  void _formatMotorista() {
    motoristaController.text = motoristaController.text.toUpperCase();
    motoristaController.selection =
        TextSelection.collapsed(offset: motoristaController.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.consulta == null
              ? 'Adicionar Consulta'
              : 'Editar Consulta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: motoristaController,
              decoration: const InputDecoration(labelText: 'Motorista'),
            ),
            _buildDropdownField(
              value: selectedBuonny,
              options: buonnyOptions,
              hint: 'Buonny',
              onChanged: (value) => setState(() => selectedBuonny = value),
            ),
            _buildDropdownField(
              value: selectedConsulta,
              options: consultaOptions,
              hint: 'Consulta',
              onChanged: (value) => setState(() => selectedConsulta = value),
            ),
            TextField(
              controller: destinoController,
              decoration: const InputDecoration(labelText: 'Destino'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addOrUpdateConsulta,
              child: Text(widget.consulta == null
                  ? 'Adicionar Consulta'
                  : 'Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required List<String> options,
    required String hint,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: options
          .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
      decoration: InputDecoration(labelText: hint),
      onChanged: onChanged,
    );
  }
}
