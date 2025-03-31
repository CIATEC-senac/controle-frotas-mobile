import 'package:flutter/material.dart';

class AppBarCard extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 233, 75, 135),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context); // Volta para a página anterior
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
