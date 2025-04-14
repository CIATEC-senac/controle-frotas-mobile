import 'package:flutter/material.dart';

class StatusTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: const TabBar(tabs: <Widget>[
        Tab(text: 'Pendente'),
        Tab(text: 'Aprovada'),
        Tab(text: 'Reprovada'),
      ]),
    );
  }
}
