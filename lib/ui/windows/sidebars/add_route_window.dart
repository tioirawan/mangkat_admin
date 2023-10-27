import 'dart:async';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/models/route_model.dart';
import '../../../domain/repositories/route_repository.dart';
import '../../../domain/services/route_service.dart';
import '../../helpers/map_helper.dart';
import '../../providers/common/content_window_controller/content_window_controller.dart';
import '../../providers/common/events/global_events.dart';
import '../../providers/common/events/global_events_provider.dart';
import '../../providers/common/map_controller/map_provider.dart';
import '../../providers/common/sections/sidebar_content_controller.dart';
import '../../providers/route/route_on_edit_provider.dart';
import '../../themes/app_theme.dart';

class AddRouteWindow extends ConsumerStatefulWidget {
  static const String name = 'window/add-route';

  final RouteModel? route;

  const AddRouteWindow({
    super.key,
    this.route,
  });

  @override
  ConsumerState<AddRouteWindow> createState() => _AddRouteWindowState();
}

class _AddRouteWindowState extends ConsumerState<AddRouteWindow> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _routeNameController = TextEditingController(
    text: widget.route?.name,
  );
  late final TextEditingController _descriptionController =
      TextEditingController(
    text: widget.route?.description,
  );

  late TimeOfDay _startTime = widget.route?.startOperation ??
      const TimeOfDay(
        hour: 7,
        minute: 0,
      );
  late TimeOfDay _endTime = widget.route?.endOperation ??
      const TimeOfDay(
        hour: 17,
        minute: 0,
      );
  late Color _color = widget.route?.color ?? Colors.blue;
  late RouteType _type = widget.route?.type ?? RouteType.fixed;

  bool _isEditingRoute = false;
  late final List<LatLng> _checkpoints = [...?widget.route?.checkpoints];
  late final Map<(LatLng, LatLng), List<LatLng>> _routes = {};

  StreamSubscription<LatLng>? _tapSubscription;

  MapControllerNotifier get mapController =>
      ref.read(mapControllerProvider.notifier);

  bool get isRouteClosed =>
      _checkpoints.length > 1 && _checkpoints.first == _checkpoints.last;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.route != null) {
        _computeAllRoutes();
        _redrawMarkers();
        ref.read(routeOnEditProvider.notifier).state = widget.route;
      }
    });

    _tapSubscription =
        ref.read(mapControllerProvider.notifier).tapStream.listen(
      (event) {
        if (!_isEditingRoute || isRouteClosed) {
          return;
        }
        _addCheckpoint(event);
      },
    );
  }

  Future<void> _addCheckpoint(LatLng latLng) async {
    setState(() {
      _checkpoints.add(latLng);
    });

    _redrawMarkers();

    if (_checkpoints.length > 1) {
      RouteService routeService = ref.read(routeServiceProvider);

      final start = _checkpoints[_checkpoints.length - 2];
      final end = _checkpoints[_checkpoints.length - 1];

      final paths = await routeService.getRouteBetweenCoordinates(start, end);

      _routes[(start, end)] = paths;
    }

    _redrawRoutes();
  }

  Future<void> _removeCheckpoint(int index) async {
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

  Future<void> _computeAllRoutes() async {
    if (_checkpoints.length < 2) {
      return;
    }

    final routeService = ref.read(routeServiceProvider);

    for (int i = 0; i < _checkpoints.length - 1; i++) {
      final start = _checkpoints[i];
      final end = _checkpoints[i + 1];

      final paths = await routeService.getRouteBetweenCoordinates(start, end);

      _routes[(start, end)] = paths;
    }

    _redrawRoutes();
  }

  Set<LatLng> _combineRoutes() {
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

  void _redrawRoutes() {
    Set<LatLng> points = _combineRoutes();

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

  void _clearPolylines() {
    const polylineId = PolylineId(
      'new_route/paths',
    );

    mapController.removePolyline(polylineId);
  }

  void _clearMarkers() {
    for (final checkpoint in _checkpoints) {
      mapController.removeMarker(MarkerId(
        'new_route/checkpoint_${checkpoint.latitude}_${checkpoint.longitude}',
      ));
    }
  }

  Future<void> _closeRoute() async {
    if (isRouteClosed) {
      return;
    }

    _addCheckpoint(_checkpoints.first);
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

  Future<void> _saveRoute() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final route = (widget.route ?? const RouteModel()).copyWith(
      name: _routeNameController.text,
      startOperation: _startTime,
      endOperation: _endTime,
      color: _color,
      type: _type,
      description: _descriptionController.text,
      checkpoints: _checkpoints,
      routes: _combineRoutes().toList(),
    );

    if (widget.route != null) {
      await ref.read(routeRepositoryProvider).updateRoute(route);
    } else {
      await ref.read(routeRepositoryProvider).addRoute(route);
    }

    _zoomToCheckpoints();
    _clearMarkers();
    _clearPolylines();
    ref.read(rightSidebarContentController.notifier).close(AddRouteWindow.name);
    ref
        .read(contentWindowProvider.notifier)
        .show(ContentWindowType.routeManager);
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

  @override
  void dispose() {
    _clearMarkers();
    _clearPolylines();
    _routeNameController.dispose();
    _descriptionController.dispose();
    _tapSubscription?.cancel();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused =
        ref.watch(mapControllerProvider.select((state) => state.isFocused));
    final colorScheme = Theme.of(context).colorScheme;

    ref.listen(globalEventsProvider, _handleWindowClosing);

    return Container(
      decoration: AppTheme.windowCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tambah Trayek',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                Material(
                  shape: const CircleBorder(),
                  color: Theme.of(context).colorScheme.error,
                  child: InkWell(
                    onTap: () => isFocused
                        ? _toggleIsEditingRoute()
                        : ref
                            .read(rightSidebarContentController.notifier)
                            .close(AddRouteWindow.name),
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close_rounded,
                        color: Theme.of(context).colorScheme.onError,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
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
                      'Rute',
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
                                _removeCheckpoint(i);
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
                              _zoomToCheckpoints();
                              _toggleIsEditingRoute();
                              return;
                            }
                            _saveRoute();
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

  void _handleWindowClosing(pref, event) {
    if (event is GlobalEventAddRouteWindowWillClose) {
      _clearMarkers();
      _clearPolylines();
      ref.read(routeOnEditProvider.notifier).state = null;
    }
  }

  Widget _buildDetailForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _routeNameController,
            decoration: const InputDecoration(
              labelText: 'Nama Trayek*',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama trayek tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                // time picker with show time picker
                child: TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _startTime.format(context),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Jam Mulai*',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jam mulai tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _endTime.format(context),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Jam Selesai*',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jam selesai tidak boleh kosong';
                    }
                    return null;
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
              Radio<RouteType>(
                value: RouteType.fixed,
                groupValue: _type,
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                  });
                },
              ),
              const Text('Tetap'),
              const SizedBox(width: 16),
              Radio<RouteType>(
                value: RouteType.temporary,
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
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Deskripsi',
              alignLabelWithHint: true,
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
