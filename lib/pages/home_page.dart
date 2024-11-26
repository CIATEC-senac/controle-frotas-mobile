import 'package:flutter/material.dart';
import 'rotas_page.dart';
import 'historico_page.dart';

class HomePage extends StatelessWidget {
  // Define uma chave global para gerenciar o Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Vincula a chave ao Scaffold
      backgroundColor: Colors.black87, // Cor de fundo da tela

      // Menu lateral (endDrawer)
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Cabeçalho do menu lateral
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey[800]),
              child: const Text(
                'Configurações',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

            // Opção "Sair"
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () {
                // Remove o menu lateral (Drawer)
                Navigator.of(context).pop();

                // Navega para a página de login e remove todas as outras da pilha
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        ),
      ),

      // Cabeçalho personalizado
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[800], // Cor de fundo do cabeçalho
              borderRadius: BorderRadius.circular(10), // Bordas arredondadas
            ),
            child: Row(
              children: [
                // Exibe o logo no lado esquerdo
                Image.asset('assets/images/logo.png', height: 50),
                const SizedBox(width: 10),

                // Informações do usuário (nome e cargo)
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'JOSÉ CARLOS DA SILVA',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Motorista',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                // Ícone de configurações
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    // Abre o menu lateral ao clicar
                    scaffoldKey.currentState!.openEndDrawer();
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      // Corpo da página
      body: Stack(
        children: [
          // Conteúdo principal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16), // Espaçamento inicial

                // Botão "Rotas"
                CustomButton(
                  title: 'Rotas',
                  subtitle: 'Ler QR Code',
                  onPressed: () {
                    // Navega para a página de Rotas
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RotasPage()),
                    );
                  },
                ),

                const SizedBox(height: 16), // Espaçamento entre os botões

                // Botão "Histórico de Rotas"
                CustomButton(
                  title: 'Histórico de rotas',
                  subtitle: '',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoricoRotasPage()),
                    );
                  },
                ),
              ],
            ),
          ),

          // Ícone de notificação no canto inferior direito
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              iconSize: 30,
              onPressed: () {
                // Implementar ação de notificações
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Componente reutilizável para botões
class CustomButton extends StatelessWidget {
  final String title; // Título do botão
  final String subtitle; // Subtítulo opcional
  final VoidCallback onPressed; // Função executada ao clicar no botão

  const CustomButton({
    required this.title,
    required this.subtitle,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[800], // Cor de fundo do botão
        padding: const EdgeInsets.symmetric(vertical: 20),
        fixedSize: const Size.fromHeight(80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Bordas arredondadas
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título do botão
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                // Subtítulo do botão (se existir)
                if (subtitle.isNotEmpty) const SizedBox(height: 5),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
          ),
          // Ícone de seta à direita
          const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }
}
