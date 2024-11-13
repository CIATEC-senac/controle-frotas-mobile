import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Cor de fundo da tela
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Altura personalizada para o AppBar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 80, // Altura do cabeçalho igual à dos botões
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[800], // Cor de fundo do cabeçalho
              borderRadius: BorderRadius.circular(10), // Bordas arredondadas para o cabeçalho
            ),
            child: Row(
              children: [
                // Logo à esquerda
                Image.asset('assets/images/logo.png', height: 50), // Insira o caminho da logo
                const SizedBox(width: 10), // Espaçamento entre a logo e as informações
                const Expanded(
                  // Informações do profissional (nome e cargo)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'JOSÉ CARLOS DA SILVA',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5), // Espaçamento entre o nome e o cargo
                      Text(
                        'Motorista',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Ícone de configurações à direita
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Ação para configurações
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16), // Espaçamento entre o cabeçalho e o primeiro botão

                // Botão "Rotas"
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800], // Cor de fundo do botão
                    padding: const EdgeInsets.symmetric(vertical: 20), // Padding interno do botão
                    fixedSize: const Size.fromHeight(80), // Altura fixa para manter a proporção
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                    ),
                  ),
                  onPressed: () {
                    // Ação para o botão "Rotas"
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0), // Espaçamento à esquerda do texto
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Rotas',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Ler QR Code',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16), // Espaçamento entre os botões

                // Botão "Histórico de Rotas"
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800], // Cor de fundo do botão
                    padding: const EdgeInsets.symmetric(vertical: 20), // Padding interno do botão
                    fixedSize: const Size.fromHeight(80), // Altura fixa para manter a proporção
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                    ),
                  ),
                  onPressed: () {
                    // Ação para o botão "Histórico de Rotas"
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0), // Espaçamento à esquerda do texto
                        child: Text(
                          'Histórico de rotas',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Ícone de notificação posicionado no canto inferior direito
          Positioned(
            bottom: 20, // Distância da base da tela
            right: 20, // Distância da borda direita
            child: IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              iconSize: 30, // Tamanho do ícone
              onPressed: () {
                // Ação para notificações
              },
            ),
          ),
        ],
      ),
    );
  }
}
