import 'dart:io';

import 'package:alfaid/api/api.dart';
import 'package:alfaid/models/route.dart';
import 'package:alfaid/pages/map_page.dart';
import 'package:alfaid/widgets/cards/odometer_card.dart';
import 'package:alfaid/widgets/scaffold_appbar.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class OdometerStartPage extends StatefulWidget {
  final RouteModel route;

  const OdometerStartPage({super.key, required this.route});

  @override
  State<OdometerStartPage> createState() => _OdometerStartPageState();
}

class _OdometerStartPageState extends State<OdometerStartPage> {
  bool _isUploading = false;
  String _odometer = "";
  File? _image;

  void imageCallback(File image) {
    setState(() {
      _image = image;
    });
  }

  void odometerCallback(String value) {
    setState(() {
      _odometer = value;
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

  void createHistory(BuildContext context) async {
    await uploadImage().then((fullFileName) {
      return API().createHistory({
        "odometerInitial": _odometer,
        "imgOdometerInitial": fullFileName,
        "driver": {"id": widget.route.driver?.id},
        "route": {"id": widget.route.id},
        "vehicle": {"id": widget.route.vehicle?.id}
      }).then((historyId) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MapPage(
              route: widget.route,
              historyId: historyId,
            ),
          ),
        );
      });
    }).catchError((e) {
      print('Error: ${e.toString()}');
    }).whenComplete(() {
      setState(() {
        _isUploading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = _image != null && _odometer.isNotEmpty;

    return Scaffold(
      appBar: const ScaffoldAppBar(title: 'Quilometragem do veículo'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 10.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    isButtonEnabled ? () => createHistory(context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonEnabled ? Colors.green : Colors.grey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Menos arredondado
                  ),
                ),
                child: Row(
                  spacing: 12.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isUploading)
                      const SizedBox(
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2.0),
                        width: 16.0,
                        height: 16.0,
                      ),
                    Text(
                      'Ir para rota',
                      style: TextStyle(
                        color: isButtonEnabled
                            ? Colors.white
                            : Colors.black, // Branco quando habilitado
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
