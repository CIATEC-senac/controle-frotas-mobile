import 'package:flutter/material.dart';

class OdometerPage extends StatelessWidget {
  const OdometerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController odometerController = TextEditingController();
    final TextEditingController fuelController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Informar Odômetro',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Volta para a página anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informe a leitura atual do odômetro:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: odometerController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Odômetro (km)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: fuelController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Inserir combustível inicial',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Inserir fotos do odômetro',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.green,
                ),
                onPressed: () {
                  // Ação ao clicar no botão da câmera para capturar a foto do odômetro
                  // Aqui você pode adicionar a lógica para abrir a câmera
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Ação ao clicar em "Enviar", como salvar o valor ou navegar
          Navigator.pop(
              context,
              odometerController
                  .text); // Retorna o valor para a página anterior
        },
        icon: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        label: const Text(
          'Enviar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8), // Reduz as bordas arredondadas
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Posiciona no canto inferior direito
    );
  }
}
