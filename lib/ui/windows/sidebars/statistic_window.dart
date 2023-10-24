import 'package:flutter/material.dart';
import 'package:flutter_polyline_no_xmlhttperror/flutter_polyline_no_xmlhttperror.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../providers/common/map_controller/map_provider.dart';
import '../../themes/app_theme.dart';

class StatisticWindow extends ConsumerStatefulWidget {
  static const String name = 'window/statistic';

  const StatisticWindow({
    super.key,
  });

  @override
  ConsumerState<StatisticWindow> createState() => _StatisticWindowState();
}

class _StatisticWindowState extends ConsumerState<StatisticWindow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.windowCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: Text(
              'Statistik',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          const Divider(height: 0),
          const ListTile(
            title: Text(
              'Jumlah Trayek',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: Text(
              '10',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Generate Polyline',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: ElevatedButton(
              onPressed: _generatePolyline,
              child: const Text(
                'Generate',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Clear Polyline',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: ElevatedButton(
              onPressed: _clearPolyline,
              child: const Text(
                'Clear',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<Color, List<LatLng>> routes = {
    const Color.fromARGB(255, 89, 126, 204): [
      const LatLng(-7.883631244459175, 112.5330562414515),
      const LatLng(-7.864694, 112.542763),
      const LatLng(-7.914730, 112.650582),
      const LatLng(-7.941551, 112.641528),
      const LatLng(-7.948949, 112.616276),
      const LatLng(-7.925800, 112.597645),
      const LatLng(-7.920997, 112.566809),
      const LatLng(-7.913362, 112.548649),
      const LatLng(-7.896695, 112.534202),
      const LatLng(-7.883631244459175, 112.5330562414515),
    ],
    const Color.fromARGB(255, 195, 236, 62): [
      const LatLng(-7.913755, 112.614616),
      const LatLng(-7.940627, 112.596192),
      const LatLng(-7.941000, 112.554386),
      const LatLng(-7.971512, 112.613259),
      const LatLng(-7.962791, 112.635914),
      const LatLng(-7.929445, 112.642249),
      const LatLng(-7.914733, 112.619340),
      const LatLng(-7.913755, 112.614616),
    ],
  };

  void _generatePolyline() async {
    final controller = ref.read(mapControllerProvider.notifier);

    const googleAPiKey = 'AIzaSyDbjkQSHEPm37DbLuICyGxXF0FjzkPxhXA';
    PolylinePoints polylinePoints = PolylinePoints(googleAPiKey);

    for (final MapEntry<Color, List<LatLng>> entry in routes.entries) {
      final color = entry.key;
      final checkpoints = entry.value;
      final routeName = color.toString();

      // calculate polyline for each route between checkpoints
      Set<LatLng> results = {};

      for (int i = 0; i < checkpoints.length - 1; i++) {
        List<LatLng> result = await polylinePoints.getRouteBetweenCoordinates(
          checkpoints[i],
          checkpoints[i + 1],
        );

        results.addAll(result);

        controller.addMarker(
          Marker(
            markerId: MarkerId('${routeName}_$i'),
            position: checkpoints[i],
            infoWindow: InfoWindow(
              title: 'Checkpoint $i',
            ),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );

        print('$routeName Length: ${checkpoints.length},  ${results.length}');

        controller.addPolyline(Polyline(
          polylineId: PolylineId('trayek_$routeName'),
          points: results.toList(),
          color: color,
          width: 5,
        ));
      }
    }
  }

  void _clearPolyline() {
    final controller = ref.read(mapControllerProvider.notifier);

    for (final MapEntry<Color, List<LatLng>> entry in routes.entries) {
      final color = entry.key;
      final checkpoints = entry.value;
      final routeName = color.toString();

      for (int i = 0; i < checkpoints.length - 1; i++) {
        controller.removeMarker(MarkerId('${routeName}_$i'));
      }

      controller.removePolyline(PolylineId('trayek_$routeName'));
    }
  }
}
