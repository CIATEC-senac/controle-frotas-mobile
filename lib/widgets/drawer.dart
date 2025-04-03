import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  String name;
  String email;

  DrawerMenu({
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
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14,
              children: [
                SwitchListTile(
                  value: darkMode,
                  title: Text('Modo escuro'),
                  secondary: Icon(Icons.sunny),
                  onChanged: (bool value) {
                    setState(() {
                      darkMode = value;
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications_none),
                  title: Text('Notificações'),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                ),
                SizedBox(
                  height: 100.0,
                ),
                ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text('Sair'),
                  subtitle: Text('Finalizar sessão'),
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
