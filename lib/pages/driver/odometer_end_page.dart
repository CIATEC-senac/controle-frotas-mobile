import 'dart:io';

import 'package:alfaid/api/api.dart';
import 'package:alfaid/pages/driver/success_page.dart';
import 'package:alfaid/widgets/cards/odometer_card.dart';
import 'package:alfaid/widgets/scaffold_appbar.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class OdometerEndPage extends StatefulWidget {
  final int historyId;

  const OdometerEndPage({super.key, required this.historyId});

  @override
  _OdometerEndPageState createState() => _OdometerEndPageState();
}

class _OdometerEndPageState extends State<OdometerEndPage> {
  bool _isUploading = false;
  String _odometer = "";
  File? _image;

  void imageCallback(File image) {
    setState(() {
      _image = image;
    });
  }

  Future<dynamic> uploadImage() {
    if (_image == null || _isUploading) {
      return Future.value(null);
    }

    setState(() {
      _isUploading = true;
    });

    const uuid = Uuid();

    String mimeType = ContentType.parse(_image!.path).mimeType;

    String id = uuid.v4();
    String fileExtension = extension(_image!.path);
    String fullFileName = '$id$fileExtension';

    String fileName = basename(fullFileName);

    return API().getSignedUrl(fileName, mimeType).then((String url) async {
      var bytes = await _image!.readAsBytes();

      return API().uploadImage(url, bytes, mimeType).then((_) => fullFileName);
    });
  }

  void updateHistory(context) async {
    await uploadImage().then((fullFileName) {
      return API().updateHistory({
        "id": widget.historyId,
        "odometerFinal": _odometer,
        "imgOdometerFinal": fullFileName,
      }).then((historyId) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SuccessPage(),
          ),
        );
      });
    }).catchError((e) {
      print('### Error: ${e.toString()}');
    }).whenComplete(() {
      setState(() {
        _isUploading = false;
      });
    });
  }

  void odometerCallback(String value) {
    setState(() {
      _odometer = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = _image != null && _odometer.isNotEmpty;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const ScaffoldAppBar(
          title: 'Informar odômetro',
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10.0,
              children: [
                OdometerCard(
                  odometer: _odometer,
                  odometerCallback: odometerCallback,
                  image: _image,
                  imageCallback: imageCallback,
                  enabled: !_isUploading,
                ),
                ElevatedButton(
                  onPressed:
                      isButtonEnabled ? () => updateHistory(context) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isButtonEnabled ? Colors.green : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Menos arredondado
                    ),
                  ),
                  child: Row(
                    spacing: 12.0,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isUploading)
                        const SizedBox(
                          width: 16.0,
                          height: 16.0,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.0),
                        ),
                      Text(
                        'Finalizar',
                        style: TextStyle(
                          color: isButtonEnabled
                              ? Colors.white
                              : Colors.black, // Branco quando habilitado
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
