import 'package:flutter/material.dart';

class ScaffoldAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function? onPressed;
  final bool leadingBack;

  const ScaffoldAppBar({
    super.key,
    required this.title,
    this.onPressed,
    this.leadingBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18.0),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: leadingBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (onPressed != null) {
                    onPressed!();
                  } else {
                    // Volta para a página anterior
                    Navigator.pop(context);
                  }
                },
              )
            : null);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
