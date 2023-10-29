import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/models/fleet_model.dart';
import '../../../domain/repositories/fleet_repository.dart';
import '../../../domain/services/image_picker_service.dart';
import '../../providers/common/sections/sidebar_content_controller.dart';
import '../../providers/route/routes_provider.dart';
import '../../themes/app_theme.dart';
import '../../widgets/route_pill.dart';

class AddFleetWindow extends ConsumerStatefulWidget {
  static const String name = 'window/add-fleet';

  final FleetModel? fleet;

  const AddFleetWindow({
    super.key,
    this.fleet,
  });

  @override
  ConsumerState<AddFleetWindow> createState() => _AddFleetWindowState();
}

// this widget is responsible for adding new fleet with this data
// String? id,
// String? vehicleNumber,
// FleetStatus? status,
// FleetType? type,
// String? notes,
class _AddFleetWindowState extends ConsumerState<AddFleetWindow> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _vehicleNumberController =
      TextEditingController(
    text: widget.fleet?.vehicleNumber,
  );
  late final TextEditingController _notesController = TextEditingController(
    text: widget.fleet?.notes,
  );
  late final TextEditingController _maxCapacityController =
      TextEditingController(
    text: widget.fleet?.maxCapacity?.toString() ?? '0',
  );

  late FleetStatus _status = widget.fleet?.status ?? FleetStatus.idle;
  late FleetType _type = widget.fleet?.type ?? FleetType.miniBus;

  late String? routeId = widget.fleet?.routeId;

  Uint8List? _image;

  bool _isSaving = false;

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    _notesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  'Tambah Armada',
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
                    onTap: () => ref
                        .read(rightSidebarContentController.notifier)
                        .close(AddFleetWindow.name),
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Foto Armada',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 75,
                  height: 75,
                  child: _image == null
                      ? (widget.fleet?.image == null
                          ? DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.1),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: FittedBox(
                                  child: Icon(
                                    Icons.image_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.1),
                                  ),
                                ),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.fleet!.image!,
                              fit: BoxFit.cover,
                            ))
                      : Image.memory(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              FilledButton(
                onPressed: _pickImage,
                child: const Text('Pilih Foto'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _vehicleNumberController,
            decoration: const InputDecoration(
              labelText: 'Nomor Kendaraan*',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nomor Kendaraan tidak boleh kosong';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<FleetType>(
            value: _type,
            decoration: const InputDecoration(
              labelText: 'Jenis Kendaraan*',
            ),
            items: FleetType.values
                .map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _type = value;
                });
              }
            },
            validator: (value) {
              if (value == null) {
                return 'Jenis Kendaraan tidak boleh kosong';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _maxCapacityController,
            decoration: const InputDecoration(
              labelText: 'Kapasitas Maksimal',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Kapasitas Maksimal tidak boleh kosong';
              } else if (int.tryParse(value) == null) {
                return 'Kapasitas Maksimal harus berupa angka';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Catatan',
              alignLabelWithHint: true,
            ),
            minLines: 1,
            maxLines: 5,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<FleetStatus>(
            value: _status,
            decoration: const InputDecoration(
              labelText: 'Status*',
            ),
            items: FleetStatus.values
                .map(
                  (status) => DropdownMenuItem(
                    value: status,
                    child: Text(status.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _status = value;
                });
              }
            },
            validator: (value) {
              if (value == null) {
                return 'Status tidak boleh kosong';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          Consumer(builder: (context, ref, _) {
            final routesState = ref.watch(routesProvider);

            return routesState.when(
              data: (routes) {
                routes = routes.where((route) => route.id != null).toList();

                return DropdownButtonFormField<String?>(
                  // in case of route is deleted
                  value: routes.any((route) => route.id == routeId)
                      ? routeId
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'Trayek',
                  ),
                  items: routes
                      .map(
                        (route) => DropdownMenuItem(
                          value: route.id,
                          child: RoutePill(route: route),
                        ),
                      )
                      .toList()
                    ..insert(
                      0,
                      const DropdownMenuItem(
                        value: null,
                        child: Text('-'),
                      ),
                    ),
                  onChanged: (value) {
                    setState(() {
                      routeId = value;
                    });
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
            );
          }),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: FilledButton(
              onPressed: _isSaving ? null : _createFleet,
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

  void _pickImage() async {
    final imagePicker = ref.read(imagePickerProvider);

    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _image = await image.readAsBytes();
      setState(() {});
    }
  }

  void _createFleet() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() => _isSaving = true);

      final fleet = (widget.fleet ?? FleetModel()).copyWith(
        id: widget.fleet?.id,
        vehicleNumber: _vehicleNumberController.text,
        status: _status,
        type: _type,
        notes: _notesController.text,
        routeId: routeId,
        maxCapacity: int.tryParse(_maxCapacityController.text) ?? 0,
      );

      final repository = ref.read(fleetRepositoryProvider);

      if (widget.fleet != null) {
        await repository.updateFleet(fleet, _image);
      } else {
        await repository.createFleet(fleet, _image);
      }

      setState(() => _isSaving = false);

      ref
          .read(rightSidebarContentController.notifier)
          .close(AddFleetWindow.name);
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );

        setState(() => _isSaving = false);
      }
    }
  }
}
