import 'package:alfaid/api/api.dart';
import 'package:alfaid/models/user.dart';
import 'package:alfaid/pages/login_page.dart';
import 'package:alfaid/pages/partials/home_manager.dart';
import 'package:alfaid/pages/partials/home_driver.dart';
import 'package:alfaid/widgets/drawer.dart';
import 'package:alfaid/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserModel? _user;

  // Permissão para acesso a câmera
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  Future<void> requestPermission() async {
    final status = await Permission.camera.request();

    setState(() {
      _permissionStatus = status;
    });
  }

  void fetchUser() async {
    API().fetchUserFromToken().then((tokenUser) {
      setState(() {
        _user = tokenUser;
      });
    }, onError: (e) async {
      print('Error: ${e.toString()}');

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove('token');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
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
            children: [getHeader(_user), getVersion(), getChildren(_user)],
          ),
        ),
      ),
    );
  }

  Text getVersion() {
    return const Text(
      "ALFAID v2.9.20 - BETA",
      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFCCCCCC)),
    );
  }

  ListItem getHeader(UserModel? user) {
    return ListItem(
      prefix: Container(
        margin: const EdgeInsets.only(right: 8.0),
        child: Image.asset('assets/images/logo.png', width: 70.0),
      ),
      title: user?.name ?? '',
      subTitle: user?.getStringRole() ?? '',
      icon: const Icon(Icons.settings),
      onPressed: () => scaffoldKey.currentState?.openDrawer(),
    );
  }

  Widget getChildren(UserModel? user) {
    return switch (user?.role) {
      UserRole.manager => ManagerHomePartial(),
      UserRole.driver => DriverHomePartial(),
      _ => Container()
    };
  }
}
