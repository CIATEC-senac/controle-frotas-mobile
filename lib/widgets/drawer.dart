import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  final String name;
  final String email;

  const DrawerMenu({
    super.key,
    required this.email,
    required this.name,
  });

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(widget.name), accountEmail: Text(widget.email)),
          Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14,
              children: [
                SwitchListTile(
                  value: darkMode,
                  title: const Text('Modo escuro'),
                  secondary: const Icon(Icons.sunny),
                  onChanged: (bool value) {
                    setState(() {
                      darkMode = value;
                    });
                  },
                ),
                // ListTile(
                //   leading: const Icon(Icons.notifications_none),
                //   title: const Text('Notificações'),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const NotificationsPage(),
                //       ),
                //     );
                //   },
                // ),
                // const SizedBox(
                //   height: 100.0,
                // ),
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('Sair'),
                  subtitle: const Text('Finalizar sessão'),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
