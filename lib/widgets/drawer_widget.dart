import 'package:alfaid/widgets/button_route.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final TextEditingController paradaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 18,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Parada não programada',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                    'Registre uma parada que não estava no plano original da rota')
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14,
              children: [
                Text(
                  'Motivo da parada',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextField(
                  controller: paradaController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Ex: Problema mecânico',
                    border: OutlineInputBorder(),
                  ),
                ),
                Text('Paradas registradas:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ButtonOptions(
                  color: Colors.blue,
                  title: 'Registrar parada',
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
