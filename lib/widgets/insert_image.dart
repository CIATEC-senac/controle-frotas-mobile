import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class InsertImage extends StatelessWidget {
  final File? image;
  final void Function(File file) callback;

  const InsertImage({super.key, required this.image, required this.callback});

  // Função para abrir câmera e tirar foto
  void _pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        callback(File(pickedFile.path));
      }
    } catch (e) {
      debugPrint("Erro ao capturar imagem: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16.0,
      children: [
        RawMaterialButton(
          onPressed: _pickImage,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: Color.fromARGB(255, 225, 227, 230), width: 1.0),
            borderRadius: BorderRadius.circular(10), // Set the radius here
          ),
          child: const SizedBox(
            height: 80.0,
            child: Row(
              spacing: 12.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.black54,
                  size: 16.0,
                ),
                Text(
                  "Abrir câmera",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
        if (image != null)
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Image.file(
              image!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          )
      ],
    );
  }
}
