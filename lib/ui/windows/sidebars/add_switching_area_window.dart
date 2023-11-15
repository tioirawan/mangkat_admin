import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../domain/models/switching_area_model.dart';
import '../../providers/common/events/global_events.dart';
import '../../providers/common/events/global_events_provider.dart';
import '../../providers/common/map_controller/map_provider.dart';
import '../../providers/common/sections/sidebar_content_controller.dart';
import '../../providers/route/routes_provider.dart';
import '../../providers/switching_area/switching_area_controller.dart';
import '../../themes/app_theme.dart';
import '../../widgets/route_pill.dart';

class AddSwitchingAreaWindow extends ConsumerStatefulWidget {
  static const String name = 'window/add-switching-area';

  final SwitchingAreaModel? switchingArea;

  const AddSwitchingAreaWindow({
    super.key,
    this.switchingArea,
  });

  @override
  ConsumerState<AddSwitchingAreaWindow> createState() =>
      _AddSwitchingAreaWindowState();
}

// this widget is responsible for adding new driver with this data
// String? id,
// String? name,
// String? phone,
// String? address,
// String? image,
// String? drivingLicenseNumber,
// DateTime? drivingLicenseExpiryDate,
class _AddSwitchingAreaWindowState
    extends ConsumerState<AddSwitchingAreaWindow> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController = TextEditingController(
    text: widget.switchingArea?.name,
  );

  late double? _latitude = widget.switchingArea?.latitude;
  late double? _longitude = widget.switchingArea?.longitude;
  late double? _radius = widget.switchingArea?.radius ?? 100;
  late final List<String> _routes = [...?widget.switchingArea?.routes];

  StreamSubscription<LatLng>? _tapSubscription;

  bool _isPickingLocation = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _tapSubscription =
        ref.read(mapControllerProvider.notifier).tapStream.listen(
      (event) {
        if (!_isPickingLocation) return;

        setState(() {
          _latitude = event.latitude;
          _longitude = event.longitude;
          _isPickingLocation = false;
        });

        ref.read(mapControllerProvider.notifier).removeFocus();

        _drawMarker();
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tapSubscription?.cancel();

    super.dispose();
  }

  void _drawMarker() {
    if (_latitude == null || _longitude == null) return;

    ref.read(mapControllerProvider.notifier).addCircle(
          'add-switching-area',
          CircleMarker(
            point: LatLng(_latitude!, _longitude!),
            radius: _radius ?? 0,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            borderColor: Theme.of(context).colorScheme.primary,
            borderStrokeWidth: 2,
            useRadiusInMeter: true,
          ),
        );

    ref.read(mapControllerProvider.notifier).addMarker(
          'add-switching-area',
          Marker(
            point: LatLng(_latitude!, _longitude!),
            width: 18,
            height: 18,
            builder: (context) => const Icon(
              Icons.alt_route_sharp,
              color: Colors.red,
              size: 10,
            ),
          ),
        );
  }

  void _clearMarkers() {
    ref.read(mapControllerProvider.notifier).removeCircle('add-switching-area');
    ref.read(mapControllerProvider.notifier).removeMarker('add-switching-area');
  }

  void _handleWindowClosing(pref, event) {
    if (event is GlobalEventAddSwitchingAreaWindowWillClose) {
      _clearMarkers();
      _isPickingLocation = false;
      ref.read(mapControllerProvider.notifier).removeFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                const Expanded(
                  child: Text(
                    'Switching Area',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
                Material(
                  shape: const CircleBorder(),
                  color: Theme.of(context).colorScheme.error,
                  child: InkWell(
                    onTap: () => ref
                        .read(rightSidebarContentController.notifier)
                        .close(AddSwitchingAreaWindow.name),
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
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildDetailForm(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailForm(BuildContext context) {
    final routes = ref.watch(routesProvider);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nama',
              hintText: 'contoh: Terminal Landungsari',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama tidak boleh kosong';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Lokasi', style: Theme.of(context).textTheme.bodySmall),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Latitude',
                  ),
                  controller: TextEditingController(
                    text: _latitude?.toStringAsFixed(6),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Longitude',
                  ),
                  controller: TextEditingController(
                    text: _longitude?.toStringAsFixed(6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _isPickingLocation = !_isPickingLocation;
                });

                if (_isPickingLocation) {
                  ref.read(mapControllerProvider.notifier).requestFocus();
                } else {
                  ref.read(mapControllerProvider.notifier).removeFocus();
                }
              },
              child: Text(_isPickingLocation ? 'Batal' : 'Pilih Lokasi'),
            ),
          ),
          const SizedBox(height: 16),
          // slider for radius
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Radius', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  '*dalam meter',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5),
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ),
          Slider(
            value: _radius ?? 0,
            min: 10,
            max: 1000,
            divisions: 100,
            label: "${_radius?.toStringAsFixed(2) ?? '0'}m",
            onChanged: (value) {
              setState(() {
                _radius = value;
              });
              _drawMarker();
            },
            // onChangeEnd: (value) => _drawMarker(),
          ),
          // multiple select for routes
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Trayek', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  '*Armada dapat dialihkan baik dari maupun ke trayek yang dipilih',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5),
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: routes.when(
              data: (routes) => routes
                  .map(
                    (route) => RoutePill(
                      route: route,
                      selected: _routes.contains(route.id),
                      onTap: () {
                        setState(() {
                          if (_routes.contains(route.id)) {
                            _routes.remove(route.id);
                          } else {
                            _routes.add(route.id!);
                          }
                        });
                      },
                    ),
                  )
                  .toList(),
              loading: () => const [CircularProgressIndicator()],
              error: (error, stackTrace) => [
                Text('$error'),
              ],
            ),
          ),

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: FilledButton(
              onPressed: _isSaving ? null : _createSwitchingArea,
              child: _isSaving
                  ? Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onSecondary,
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : const Text('Simpan'),
            ),
          ),
        ],
      ),
    );
  }

  void _createSwitchingArea() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() => _isSaving = true);

      final switchingArea =
          (widget.switchingArea ?? SwitchingAreaModel()).copyWith(
        id: widget.switchingArea?.id,
        name: _nameController.text,
        latitude: _latitude,
        longitude: _longitude,
        radius: _radius,
        routes: _routes,
      );

      final repository = ref.read(switchingAreaControllerProvider);

      if (widget.switchingArea != null) {
        await repository.update(switchingArea);
      } else {
        await repository.add(switchingArea);
      }

      setState(() => _isSaving = false);

      ref
          .read(rightSidebarContentController.notifier)
          .close(AddSwitchingAreaWindow.name);
    } on Exception catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$error'),
          ),
        );

        setState(() => _isSaving = false);
      }
    }
  }
}
