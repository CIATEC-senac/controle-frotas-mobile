import 'package:flutter/material.dart';

class HistoricoRotasPage extends StatefulWidget {
  const HistoricoRotasPage({super.key});

  @override
  _HistoricoRotasPageState createState() => _HistoricoRotasPageState();
}

class _HistoricoRotasPageState extends State<HistoricoRotasPage> {
  String selectedMonth = 'Selecione o mês';
  final List<Map<String, String>> historicoRotas = [
    {"data": "20/06/2024", "inicio": "12:00", "fim": "12:30"},
    // Adicione mais dados aqui, se necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Histórico de rotas",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Função para atualizar os dados
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Linha com o título e o dropdown alinhado à direita
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Selecione o mês",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                DropdownButton<String>(
                  value: selectedMonth,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  dropdownColor: Colors.black87,
                  style: const TextStyle(color: Colors.white),
                  items: <String>[
                    'Selecione o mês',
                    'Janeiro',
                    'Fevereiro',
                    'Março',
                    'Abril',
                    'Maio',
                    'Junho',
                    'Julho',
                    'Agosto',
                    'Setembro',
                    'Outubro',
                    'Novembro',
                    'Dezembro',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Títulos das colunas
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Data",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  "Início",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  "Fim",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            const Divider(color: Colors.white), // Linha para separação
            Expanded(
              child: ListView.builder(
                itemCount: historicoRotas.length,
                itemBuilder: (context, index) {
                  final rota = historicoRotas[index];
                  return Card(
                    color: Colors.grey[800],
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            rota['data']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            rota['inicio']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            rota['fim']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
