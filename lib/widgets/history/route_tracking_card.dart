import 'package:alfaid/models/history_track.dart';
import 'package:alfaid/models/route_path_coordinates.dart';
import 'package:alfaid/utils/static_map.dart';
import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RouteTrackingCard extends StatelessWidget {
  final List<HistoryTrackModel> track;

  const RouteTrackingCard({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      icon: LucideIcons.map,
      title: 'Rota Executada',
      children: [
        HistoryStaticMap(
          track: track
              .map(
                (coordinate) => Coordinates(
                  lat: coordinate.latitude,
                  lng: coordinate.longitude,
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
