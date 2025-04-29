import 'package:alfaid/api/api.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:toastification/toastification.dart';

class UnplannedStopButton {
  final String label;
  final String icon;
  final int value;

  const UnplannedStopButton({
    required this.label,
    required this.icon,
    required this.value,
  });
}

Widget stopButton(
    UnplannedStopButton stop, int historyId, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Location location = Location();

      location.getLocation().then((locationData) {
        API().addUnplannedStop(historyId, {
          "coordinates": {
            "lat": locationData.latitude,
            "lng": locationData.longitude
          },
          "type": stop.value
        }).catchError((e) {
          print('### Error: ${e.toString()}');
        });
      });

      toastification.show(
          type: ToastificationType.success,
          title: const Text('Parada adicionada com sucesso'),
          alignment: Alignment.topCenter,
          autoCloseDuration: const Duration(seconds: 3),
          borderRadius: BorderRadius.circular(4.0),
          style: ToastificationStyle.flat);

      Navigator.pop(context);
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4.0,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Image.asset('assets/images/${stop.icon}'),
        ),
        Text(stop.label, textAlign: TextAlign.center)
      ],
    ),
  );
}

Widget unprogrammedStopsDialog(BuildContext context, int historyId) {
  List<UnplannedStopButton> stops = const [
    UnplannedStopButton(
      label: "Trânsito",
      value: 0,
      icon: "heavy-traffic.png",
    ),
    UnplannedStopButton(
      label: "Via interditada",
      value: 1,
      icon: "traffic-barrier.png",
    ),
    UnplannedStopButton(
      label: "Faixa bloqueada",
      value: 2,
      icon: "traffic-cone.png",
    ),
    UnplannedStopButton(
      label: "Combustível",
      value: 3,
      icon: "gas-pump.png",
    ),
    UnplannedStopButton(
      label: "Problema mecânico",
      value: 4,
      icon: "service.png",
    ),
    UnplannedStopButton(
      label: "Acidente",
      value: 5,
      icon: "warning.png",
    ),
  ];

  return Container(
    decoration: const BoxDecoration(color: Colors.white),
    height: 420.0,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 32.0, left: 32.0, right: 32.0),
          child: const Text(
            'Registrar parada não progranada',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        Container(
          height: 320.0,
          padding: const EdgeInsets.all(16.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            children: stops
                .map(
                  (stop) => stopButton(stop, historyId, context),
                )
                .toList(),
          ),
        )
      ],
    ),
  );
}
