import 'dart:convert';

import 'package:alfaid/api/api.dart';
import 'package:alfaid/models/user.dart';
import 'package:alfaid/pages/historico_page.dart';
import 'package:alfaid/widgets/drawer.dart';
import 'package:alfaid/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'scanner_route_page.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Permissão para acesso a câmera
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  Future<void> requestPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      _permissionStatus = status;
    });
  }

  UserModel? _user;

  void fetchUser() async {
    API().fetchUser(1).then((user) {
      setState(() {
        _user = user;
      });
    }, onError: (e) {
      print(e.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
    fetchUser();
  }

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerMenu(
        name: _user?.name ?? '',
        email: _user?.email ?? '',
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 8.0,
            children: [
              ListItem(
                prefix: Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 70.0,
                  ),
                ),
                title: _user?.name ?? '',
                subTitle: _user?.cargo ?? '',
                icon: const Icon(Icons.settings),
                onPressed: () => {scaffoldKey.currentState?.openDrawer()},
              ),
              const Text(
                "ALFAID v2.9.20 - BETA",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFFCCCCCC)),
              ),
              ListItem(
                title: "Rota",
                subTitle: "Subtitulo",
                onPressed: () {
                  // Navega para a página de Rotas
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScannerRoutePage()),
                  );
                },
              ),
              ListItem(
                title: "Rota",
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
      ),
    );
  }
}
