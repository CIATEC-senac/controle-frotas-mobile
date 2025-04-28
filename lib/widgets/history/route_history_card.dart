import 'package:alfaid/models/history.dart';
import 'package:alfaid/models/route_path_coordinates.dart';
import 'package:alfaid/utils/static_map.dart';
import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:alfaid/widgets/detail_row.dart';
import 'package:daydart_flutter/daydart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RouteHistoryCard extends StatefulWidget {
  final RouteHistoryModel history;

  const RouteHistoryCard({
    super.key,
    required this.history,
  });

  @override
  State<RouteHistoryCard> createState() => _RouteHistoryCardState();
}

class _RouteHistoryCardState extends State<RouteHistoryCard> {
  PolylinePoints polylinePoints = PolylinePoints();

  PolylineResult? _polylineResult;

  void getPolylines() async {
    var polylineRequest = PolylineRequest(
      origin: PointLatLng(
        widget.history.route.coordinates.origin!.lat,
        widget.history.route.coordinates.origin!.lng,
      ),
      destination: PointLatLng(
        widget.history.route.coordinates.destination!.lat,
        widget.history.route.coordinates.destination!.lng,
      ),
      mode: TravelMode.driving,
      optimizeWaypoints: true,
      wayPoints: widget.history.route.path.stops!
          .map((waypoint) => PolylineWayPoint(location: waypoint))
          .toList(),
    );

    polylinePoints
        .getRouteBetweenCoordinates(
      googleApiKey: const String.fromEnvironment(
        'GOOGLE_MAPS_APIKEY',
        defaultValue: 'AIzaSyAtnsmelP2XXZQxSgDOnn9ra2RLv3LOKWA',
      ),
      request: polylineRequest,
    )
        .then((result) {
      setState(() {
        _polylineResult = result;
      });
    });
  }

  @override
  void initState() {
    getPolylines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var origin = widget.history.route.path.origin;
    var destination = widget.history.route.path.destination;

    return DetailCard(
      icon: LucideIcons.pin,
      title: 'Rota ${widget.history.route.name}',
      children: [
        if (_polylineResult != null)
          HistoryStaticMap(
            track: _polylineResult!.points
                .map((point) =>
                    Coordinates(lat: point.latitude, lng: point.longitude))
                .toList(),
          ),
        DetailRow(label: 'Origem:', value: origin),
        DetailRow(label: 'Destino:', value: destination),
        DetailRow(
            label: 'Hora de início:',
            value: widget.history.startedAt != null
                ? DayDart(widget.history.startedAt)
                    .subtract(3, DayUnits.h)
                    .format('dd/MM/yyyy HH:mm:ss')
                : 'N/A'),
        DetailRow(
            label: 'Hora de término:',
            value: widget.history.endedAt != null
                ? DayDart(widget.history.endedAt)
                    .subtract(3, DayUnits.h)
                    .format('dd/MM/yyyy HH:mm:ss')
                : 'N/A'),
        DetailRow(
          label: 'Tempo previsto:',
          value: '${widget.history.route.estimatedDuration.toString()} min',
        ),
        DetailRow(
            label: 'Tempo executado:',
            value: '${widget.history.elapsedDuration} min'),
        DetailRow(
            label: 'Distância prevista:',
            value: '${widget.history.route.kmEstimatedDistance.toString()} km'),
        DetailRow(
            label: 'Distância percorrida:',
            value: '${widget.history.elapsedDistance} km'),
      ],
    );
  }
}
