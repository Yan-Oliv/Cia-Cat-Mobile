import 'package:ciacat_notlog/screens/consultas/consultas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'carregamento.dart';
import 'home_screen.dart';
import 'manifesto.dart';

class Mensagens extends StatelessWidget {
  const Mensagens({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MensagensScreen(),
    );
  }
}

class MensagensScreen extends StatelessWidget {
  final Map<String, String> messagesWhirl = {
    "KIT AMARRAÇÕES (Baú)": "*KIT PARA CARRETAS BAÚ PADRÃO:*\n"
        "* 10 cantoneiras de papelão de 500mm de comprimento (Opcional vazado de 20mm);\n* 16 cantoneiras de papelão de 1000mm de comprimento (Opcional vazado de 20mm);\n* 13 cintas catracadas com gancho e revestimento de proteção de catraca;\n* 01 madeirite com cantos arredondados e com mínimo de 10mm de espessura.\n\nAs cantoneiras mencionadas aqui podem ser de PVC também, mas todas na mesma medida.",
  };

  final Map<String, String> messagesCCM = {
    "Obrigatório Padrão":
        "*OBRIGATÓRIO:*\nLona para forrar o assoalho\n*OBS:* Caso não possua a lona, podemos pedir para você, onde será descontado o valor de R\$110,00.",
    "Obrigatório Baú":
        "Para baú, precisa ter:\n* 2 folhas de madeirite\n* Pedaços de corda para amarrar os madeirites",
    "Obrigatório Sider":
        "Para sider, precisa ter:\n* 4 réguas laterais (no mínimo 3)\n* 24 madeirites lateral",
  };

  final Map<String, String> messagesDocs = {
    "Documentos Cadastro":
        "*FAVOR MANDAR A SEGUINTE DOCUMENTAÇÃO EM FOTO ABERTA OU PDF:*\n* CAVALO\n* CARRETA\n* ANTT\n* CNH DO MOTORISTA\n* ENDEREÇO DO MOTORISTA\n* CONTATO DO MOTORISTA\n* FOTO DE DENTRO DO BAÚ OU SIDER QUE SEJA\n* FOTO DO VEÍCULO INTEIRO\n* UMA SELFIE DO MOTORISTA COM CNH AO LADO DO ROSTO\n* UMA REFERÊNCIA PESSOAL DO MOTORISTA, PODE SER ALGUM CONTATO DE ALGUM PARENTE\n* UMA REFERÊNCIA COMERCIAL, CONTATO DE ALGUMA TRANSPORTADORA QUE O MOTORISTA CARREGOU\n* QUANTIDADE DE PALETES QUE SUPORTA\n* METRAGEM CÚBICA DO CAMINHÃO\n* TAG DO PEDÁGIO (CÓDIGO DE IDENTIFICAÇÃO E MARCA)",
    "Dados Bancários":
        "Assim que possível, me encaminhe seus dados bancários por favor:\n* Banco\n* Agência\n* Conta\n* Chave Pix\n* Nome do benefíciario",
    "Rota de Entrega":
        "Por favor me informe as cidades que irá passar para realizar a entrega, devido a nova lei implementada, precisamos pagar seu pedágio na TAG e pra isso precisamos saber as cidades exatas que passará.",
  };

  final Map<String, String> messagesNotas = {
    "Notas Carregamento Platina":
        "Assim que você carregar me manda as fotos de todas as notas pegando somente a baixo do código de barras, "
            "mostrando os números das chaves de acesso e me mande também a foto da folha inteira que vai está escrito "
            "*“PROTOCOLO DE NFE”* ok?",
    "Notas Carregamento CCM/TMRC":
        "Assim que carregar, me mande as fotos de todas notas de duas em duas mostrando somente abaixo do código de, "
            "barras e mostrando no meio o numero da nota como no exemplo, e me manda também a foto do romaneio inteiro, ok?",
  };

  final Map<String, String> messagesCanhotos = {
    "Canhotos Descarga":
        "AO FINALIZAR A DESCARGA, FAVOR ME ENVIAR AS FOTOS DOS CANHOTOS DATADOS, ASSINADOS E CARIMBADOS. "
            "TANTO DAS NOTAS DE PRODUTOS QUANTO DE PALETES.",
    "Endereço Envio dos Canhotos": "Favor enviar os canhotos no endereço abaixo:\n"
        "Rua Paulo Luiz Colgnese, 190\n"
        "Bairro: Loteamento Santa Rosa\n"
        "Piracicaba - SP\n"
        "CEP: 13414-125\n"
        "Em nome da Cia Cargas\n"
        "E logo depois mandar a foto do rastreamento do comprovante do correios para a liberação do saldo."
  };

  final Map<String, String> messagesInfo = {
    "CTE":
        "Verifique se foi enviada uma mensagem seguindo o seguinte modelo junto ao CTE e me encaminhe por favor\n\n"
            "*CTE E MDFE - SEU_NOME - CTE 00000 CF 00000*",
    "Desconto Buonny (1º Carregamento)":
        "Para primeiro carregamento com a empresa, é descontado o valor de R\$80,00 devido ao cadastro buonny pela empresa.",
    "Desconto Buonny (2º Carregamento (OK))":
        "Para os demais carregamentos, onde é realizado apenas a consulta buonny, é descontado o valor de R\$10,00.",
    "Desconto Buonny (2º Carregamento (FALHA))":
        "Para os demais carregamentos, onde é realizado apenas a consulta buonny, porém houve algum problema na consulta, "
            "como 'insuficiência de dados', é descontado o valor de R\$35,00 para nova consulta.",
  };

  final Map<String, String> messagesLoc = {
    "PLATINA": "A empresa aonde você vai carregar se chama *“PLATINA “* ok?\n\n"
        "AV. FRANCISCO PODBOY, Número: 1551, "
        "BAIRRO: DISTRITO INDUSTRIAL 01, GALPÃO 01\n"
        "*Localização:* https://maps.app.goo.gl/D9VrK2bzGSrt5aiEA\n\n"
        "*OBS:* Chegando lá, você fala que vai carregar pela transportadora *CIA CARGAS*",
    "CCM": "CCM INDÚSTRIA E COMÉRCIO DE PRODUTOS DESCARTÁVEIS S/A\n"
        "Av. Cel. Zacarias Borges de Araújo, 1.077 "
        "- Distrito Industrial I, Uberaba - MG, 38064-700\n"
        "(34) 3326-5800\n"
        "https://maps.app.goo.gl/PsVDCUtGD7rpdF9Z8",
    "WHIRLPOLL": "*WHIRLPOOL LATIN AMERICA*\n"
        "RUA DONA FRANCISCA, 7200 JOINVILLE-SC\n"
        "*Contato empresa:* +55 (47) 93803-4000\n"
        "*Localização:* https://maps.app.goo.gl/hxbKV4w5Mxed7QFA8",
    "CANTONEIRAS WHIRLPOOL": "COLETAR CANTONEIRAS PARA A CARGA:\n"
        "*Localização:* https://maps.app.goo.gl/sMBY5VAwDAFgjNZE6\n"
        "*(CASA DAS EMBALAGENS)*",
    "CD PLATINA EXTREMA":
        "Segue a localização do local de coleta/carregamento:\n"
            "*Localização:* https://maps.app.goo.gl/idGRYAwyCwpnDSfn6\n"
            "*CD PLATINA EXTREMA-MG*",
    "ECOMASTER": "Segue a localização do local de coleta/carregamento:\n"
        "*Localização:* https://maps.app.goo.gl/fyXJENqGjLcQ345p9\n"
        "*ECOMASTER*",
    "BRITVIC": "Segue a localização do local de coleta/carregamento:\n"
        "*Localização:* https://maps.app.goo.gl/EHT4kzAmB6827qo87\n"
        "*BRITVIC*",
  };

  MensagensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mensagens',
          style: TextStyle(color: Colors.white),
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home), // Ícone de Home
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
      body: DefaultTabController(
        length: 7, // Quantidade de abas
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.kitchen)), // Geladeira (Whirlpool)
                Tab(icon: Icon(Icons.child_care)), // Fralda ou bebê (CCM)
                Tab(icon: Icon(Icons.calendar_today)), // Agenda (Documentos)
                Tab(icon: Icon(Icons.note)), // Papel (Notas de Carregamento)
                Tab(icon: Icon(Icons.assignment)), // Prancheta (Canhotos)
                Tab(icon: Icon(Icons.search)), // Lupa (Informações)
                Tab(icon: Icon(Icons.map)), // Mapa ou Localizações
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Primeira aba: Whirpool
              ListView.builder(
                itemCount: messagesWhirl.length,
                itemBuilder: (context, index) {
                  String key = messagesWhirl.keys.elementAt(index);
                  String value = messagesWhirl[key]!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => copyToClipboard(context, value),
                      child: Text(key),
                    ),
                  );
                },
              ),
              // Segunda aba: CCM/TMRC
              ListView.builder(
                itemCount: messagesCCM.length,
                itemBuilder: (context, index) {
                  String key = messagesCCM.keys.elementAt(index);
                  String value = messagesCCM[key]!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => copyToClipboard(context, value),
                      child: Text(key),
                    ),
                  );
                },
              ),
              // Terceira aba: Documentos
              ListView.builder(
                itemCount: messagesDocs.length,
                itemBuilder: (context, index) {
                  String key = messagesDocs.keys.elementAt(index);
                  String value = messagesDocs[key]!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => copyToClipboard(context, value),
                      child: Text(key),
                    ),
                  );
                },
              ),
              // Quarta aba: Notas
              ListView.builder(
                itemCount: messagesNotas.length,
                itemBuilder: (context, index) {
                  String key = messagesNotas.keys.elementAt(index);
                  String value = messagesNotas[key]!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => copyToClipboard(context, value),
                      child: Text(key),
                    ),
                  );
                },
              ),
              // Quinta aba: Canhotos
              ListView.builder(
                itemCount: messagesCanhotos.length,
                itemBuilder: (context, index) {
                  String key = messagesCanhotos.keys.elementAt(index);
                  String value = messagesCanhotos[key]!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => copyToClipboard(context, value),
                      child: Text(key),
                    ),
                  );
                },
              ),
              // Sexta aba: Informações
              ListView.builder(
                itemCount: messagesInfo.length,
                itemBuilder: (context, index) {
                  String key = messagesInfo.keys.elementAt(index);
                  String value = messagesInfo[key]!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => copyToClipboard(context, value),
                      child: Text(key),
                    ),
                  );
                },
              ),
              // Sétima aba: Localizações
              ListView.builder(
                itemCount: messagesLoc.length,
                itemBuilder: (context, index) {
                  String key = messagesLoc.keys.elementAt(index);
                  String value = messagesLoc[key]!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => copyToClipboard(context, value),
                      child: Text(key),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Texto copiado com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

void main() {
  runApp(const Mensagens());
}
