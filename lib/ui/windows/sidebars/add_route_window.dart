import 'dart:async';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/services/route_service.dart';
import '../../helpers/map_helper.dart';
import '../../providers/common/map_controller/map_provider.dart';
import '../../themes/app_theme.dart';

class AddRouteWindow extends ConsumerStatefulWidget {
  static const String name = 'window/add-route';

  const AddRouteWindow({
    super.key,
  });

  @override
  ConsumerState<AddRouteWindow> createState() => _AddRouteWindowState();
}

class _AddRouteWindowState extends ConsumerState<AddRouteWindow> {
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  Color _color = Colors.blue;
  String _type = 'FIXED'; // valid value: FIXED, TEMPORARY

  bool _isEditingRoute = false;
  final List<LatLng> _checkpoints = [];
  final Map<(LatLng, LatLng), List<LatLng>> _routes = {};

  StreamSubscription<LatLng>? _tapSubscription;

  MapControllerNotifier get mapController =>
      ref.read(mapControllerProvider.notifier);

  bool get isRouteClosed =>
      _checkpoints.length > 1 && _checkpoints.first == _checkpoints.last;

  @override
  void initState() {
    super.initState();

    _tapSubscription =
        ref.read(mapControllerProvider.notifier).tapStream.listen(
      (event) {
        if (!_isEditingRoute || isRouteClosed) {
          return;
        }
        addCheckpoint(event);
      },
    );
  }

  Future<void> addCheckpoint(LatLng latLng) async {
    setState(() {
      _checkpoints.add(latLng);
    });

    _redrawMarkers();

    RouteService routeService = ref.read(routeServiceProvider);

    if (_checkpoints.length > 1) {
      final start = _checkpoints[_checkpoints.length - 2];
      final end = _checkpoints[_checkpoints.length - 1];

      final paths = await routeService.getRouteBetweenCoordinates(start, end);

      _routes[(start, end)] = paths;
    }

    _redrawRoutes();
  }

  Future<void> removeCheckpoint(int index) async {
    final LatLng checkpoint = _checkpoints[index];

    // special case for the closing checkpoint cause it's the same as the first, we dont want to remove both
    if (checkpoint == _checkpoints.first && isRouteClosed) {
      if (index == _checkpoints.length - 1) {
        _checkpoints.removeAt(index);
        _routes.removeWhere(
          (key, value) => key.$2 == checkpoint,
        );

        setState(() {});
        _redrawRoutes();

        // no need to remove marker, because its still being used as the first checkpoint
        return;
      } else {
        _checkpoints.removeAt(index);
        _checkpoints.removeAt(_checkpoints.length - 1);
        _routes.removeWhere(
          (key, value) => key.$1 == checkpoint || key.$2 == checkpoint,
        );

        setState(() {});
        _redrawRoutes();

        mapController.removeMarker(MarkerId(
          'new_route/checkpoint_${checkpoint.latitude}_${checkpoint.longitude}',
        ));

        // no need to remove marker, because its still being used as the first checkpoint
        return;
      }
    }

    mapController.removeMarker(MarkerId(
      'new_route/checkpoint_${checkpoint.latitude}_${checkpoint.longitude}',
    ));

    // check if there is a route between the checkpoint
    LatLng? prefLat;
    LatLng? nextLat;
    for (final (origin, destination) in _routes.keys) {
      if (origin == checkpoint || destination == checkpoint) {
        LatLng other = checkpoint == origin ? destination : origin;

        int otherIndex = _checkpoints.indexOf(other);

        if (otherIndex < index) {
          prefLat = other;
        } else {
          nextLat = other;
        }
      }
    }

    // remove the calculated route
    _routes.removeWhere(
      (key, value) => key.$1 == checkpoint || key.$2 == checkpoint,
    );

    // if there is a route between the checkpoint, recalculate the route
    if (prefLat != null && nextLat != null) {
      final routeService = ref.read(routeServiceProvider);

      final paths = await routeService.getRouteBetweenCoordinates(
        prefLat,
        nextLat,
      );

      _routes[(prefLat, nextLat)] = paths;
    }

    _checkpoints.removeAt(index);

    setState(() {});
    _redrawMarkers();
    _redrawRoutes();
  }

  void _redrawMarkers() {
    // draw markers
    for (final checkpoint in _checkpoints) {
      mapController.addMarker(
        Marker(
          markerId: MarkerId(
            'new_route/checkpoint_${checkpoint.latitude}_${checkpoint.longitude}',
          ),
          position: checkpoint,
          infoWindow: InfoWindow(
            title: 'Checkpoint ${_checkpoints.length}',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    }
  }

  Set<LatLng> _computeRoutes() {
    Set<LatLng> points = {};

    LatLng? lastPoint = _checkpoints.isNotEmpty ? _checkpoints.first : null;

    for (final checkpoint in _checkpoints) {
      if (lastPoint != null) {
        points.addAll(_routes[(lastPoint, checkpoint)] ?? []);
      }

      lastPoint = checkpoint;
    }

    return points;
  }

  void _redrawRoutes() {
    Set<LatLng> points = _computeRoutes();

    const polylineId = PolylineId(
      'new_route/paths',
    );

    final polyline = Polyline(
      polylineId: polylineId,
      points: points.toList(),
      color: _color,
      width: 5,
    );

    mapController.removePolyline(polylineId);
    mapController.addPolyline(polyline);
  }

  Future<void> _closeRoute() async {
    if (isRouteClosed) {
      return;
    }

    addCheckpoint(_checkpoints.first);

    _zoomToCheckpoints();

    // _isEditingRoute = false;
    // mapController.removeFocus();
  }

  void _zoomToCheckpoints() {
    Set<LatLng> points = {};
    for (final point in _routes.values) {
      points.addAll(point);
    }
    final bound = MapHelper.computeBounds(points.toList());

    if (bound == null) {
      return;
    }

    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        bound,
        100,
      ),
    );
  }

  @override
  void dispose() {
    _routeNameController.dispose();
    _descriptionController.dispose();
    _tapSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: AppTheme.windowCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Tambah Trayek',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          // if (!_isEditingRoute)
          AnimatedSwitcher(
            duration: 200.milliseconds,
            transitionBuilder: (child, animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: child,
              );
            },
            child: _isEditingRoute
                ? const SizedBox.shrink(
                    key: ValueKey('map'),
                  )
                : Column(
                    key: const ValueKey('form'),
                    children: [
                      const Divider(height: 0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _isEditingRoute
                            ? const SizedBox.shrink()
                            : _buildDetailForm(context),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
          ),
          const Divider(height: 0),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Checkpoints',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Material(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(4),
                      child: InkWell(
                        onTap: _zoomToCheckpoints,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.zoom_out_map,
                            size: 12,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // toggle edit route button
                    Material(
                      color: _isEditingRoute
                          ? colorScheme.primary
                          : colorScheme.surface,
                      borderRadius: BorderRadius.circular(4),
                      child: InkWell(
                        onTap: _toggleIsEditingRoute,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            _isEditingRoute
                                ? Icons.edit_off
                                : Icons.edit_outlined,
                            size: 18,
                            color: _isEditingRoute
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (_checkpoints.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Teekan tombol edit checkpoint, kemudian tap pada peta untuk menambahkan checkpoint',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorScheme.onBackground.withOpacity(0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                for (int i = 0; i < _checkpoints.length; i++)
                  InkWell(
                    onTap: () {
                      mapController.animateCamera(
                        CameraUpdate.newLatLngZoom(
                          _checkpoints[i],
                          16,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Checkpoint ${i + 1}',
                              ),
                              Text(
                                '${_checkpoints[i].latitude}, ${_checkpoints[i].longitude}',
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Material(
                            color: colorScheme.error,
                            borderRadius: BorderRadius.circular(4),
                            child: InkWell(
                              onTap: () {
                                removeCheckpoint(i);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  size: 12,
                                  color: colorScheme.onError,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: FilledButton(
                    onPressed: _checkpoints.length > 1 && !isRouteClosed
                        ? _closeRoute
                        : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.secondary,
                    ),
                    child: const Text('Tutup Loop'),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: FilledButton(
                    onPressed: _checkpoints.length > 1
                        ? () {
                            if (_isEditingRoute) {
                              _toggleIsEditingRoute();
                              return;
                            }
                          }
                        : null,
                    child: _isEditingRoute
                        ? const Text('Selesai')
                        : const Text('Simpan'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _toggleIsEditingRoute() {
    setState(() {
      _isEditingRoute = !_isEditingRoute;

      if (_isEditingRoute) {
        mapController.requestFocus();
      } else {
        mapController.removeFocus();
      }
    });
  }

  Widget _buildDetailForm(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _routeNameController,
          decoration: const InputDecoration(
            labelText: 'Nama Trayek',
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              // time picker with show time picker
              child: TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: _startTime.format(context),
                ),
                decoration: const InputDecoration(
                  labelText: 'Jam Mulai',
                ),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _startTime,
                  );

                  if (time != null) {
                    setState(() {
                      _startTime = time;
                    });
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: _endTime.format(context),
                ),
                decoration: const InputDecoration(
                  labelText: 'Jam Selesai',
                ),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _endTime,
                  );

                  if (time != null) {
                    setState(() {
                      _endTime = time;
                    });
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4,
          ),
          child: SizedBox(
            height: 247,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Warna',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ColorPicker(
                    // Use the screenPickerColor as start color.
                    color: _color,
                    // Update the screenPickerColor using the callback.
                    onColorChanged: (Color color) {
                      setState(() => _color = color);
                      _redrawRoutes();
                    },
                    width: 28,
                    height: 28,
                    borderRadius: 8,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    borderColor: Colors.transparent,
                    pickersEnabled: const <ColorPickerType, bool>{
                      ColorPickerType.both: false,
                      ColorPickerType.primary: true,
                      ColorPickerType.accent: false,
                      ColorPickerType.bw: false,
                      ColorPickerType.custom: false,
                      ColorPickerType.wheel: false,
                    },
                    enableShadesSelection: true,
                    hasBorder: false,
                    heading: null,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    subheading: const Text(
                      'Shade',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Jenis',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Radio<String>(
              value: 'FIXED',
              groupValue: _type,
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
            ),
            const Text('Tetap'),
            const SizedBox(width: 16),
            Radio<String>(
              value: 'TEMPORARY',
              groupValue: _type,
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
            ),
            const Text('Sementara'),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Deskripsi',
            alignLabelWithHint: true,
          ),
          maxLines: 3,
        ),
      ],
    );
  }
}
