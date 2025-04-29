import 'package:alfaid/models/route_path_coordinates.dart';
import 'package:flutter/material.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

class HistoryStaticMap extends StatelessWidget {
  final List<Coordinates> track;

  const HistoryStaticMap({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = width * 16 / 9;

    return StaticMap(
      googleApiKey: const String.fromEnvironment(
        'GOOGLE_MAPS_APIKEY',
        defaultValue: 'AIzaSyAtnsmelP2XXZQxSgDOnn9ra2RLv3LOKWA',
      ),
      width: width,
      height: height,
      scaleToDevicePixelRatio: true,
      zoom: 14,
      visible: [GeocodedLocation.latLng(track.first.lat, track.first.lng)],
      paths: <Path>[
        Path(
          color: Colors.blue,
          points: track
              .map(
                (coordinate) => Location(
                  coordinate.lat,
                  coordinate.lng,
                ),
              )
              .toList(),
        ),
      ],
      markers: [
        Marker(locations: [
          GeocodedLocation.latLng(track.first.lat, track.first.lng),
          GeocodedLocation.latLng(track.last.lat, track.last.lng)
        ])
      ],
    );
  }

// ***
}
