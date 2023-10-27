import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/models/driver_model.dart';
import '../../../domain/repositories/driver_repository.dart';
import '../../../domain/services/image_picker_service.dart';
import '../../providers/common/sections/sidebar_content_controller.dart';
import '../../themes/app_theme.dart';

class AddDriverWindow extends ConsumerStatefulWidget {
  static const String name = 'window/add-driver';

  final DriverModel? driver;

  const AddDriverWindow({
    super.key,
    this.driver,
  });

  @override
  ConsumerState<AddDriverWindow> createState() => _AddDriverWindowState();
}

// this widget is responsible for adding new driver with this data
// String? id,
// String? name,
// String? phone,
// String? address,
// String? image,
// String? drivingLicenseNumber,
// DateTime? drivingLicenseExpiryDate,
class _AddDriverWindowState extends ConsumerState<AddDriverWindow> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController = TextEditingController(
    text: widget.driver?.name,
  );
  late final TextEditingController _phoneController = TextEditingController(
    text: widget.driver?.phone,
  );
  late final TextEditingController _addressController = TextEditingController(
    text: widget.driver?.address,
  );
  late final TextEditingController _drivingLicenseNumberController =
      TextEditingController(
    text: widget.driver?.drivingLicenseNumber,
  );

  late DateTime _drivingLicenseExpiryDate =
      widget.driver?.drivingLicenseExpiryDate ??
          DateTime.now().add(const Duration(days: 365));

  Uint8List? _image;

  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _drivingLicenseNumberController.dispose();

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
                  'Tambah Pengemudi',
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
                        .close(AddDriverWindow.name),
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
                      ? (widget.driver?.image == null
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
                              imageUrl: widget.driver!.image!,
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
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nama Pengemudi',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama pengemudi tidak boleh kosong';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'No. Telp.',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'No. Telp. tidak boleh kosong';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Alamat',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Alamat tidak boleh kosong';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _drivingLicenseNumberController,
            decoration: const InputDecoration(
              labelText: 'No. SIM',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'No. SIM tidak boleh kosong';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Masa Berlaku SIM',
                    suffixIcon: Icon(Icons.calendar_today_rounded),
                  ),
                  controller: TextEditingController(
                    text: _drivingLicenseExpiryDate
                        .toLocal()
                        .toString()
                        .split(' ')[0],
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _drivingLicenseExpiryDate,
                      firstDate: DateTime.now(),
                      lastDate:
                          DateTime.now().add(const Duration(days: 365 * 5)),
                    );

                    if (date != null) {
                      setState(() => _drivingLicenseExpiryDate = date);
                    }
                  },
                ),
              ),
            ],
          ),
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

      final driver = (widget.driver ?? DriverModel()).copyWith(
        id: widget.driver?.id,
        name: _nameController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        drivingLicenseNumber: _drivingLicenseNumberController.text,
        drivingLicenseExpiryDate: _drivingLicenseExpiryDate,
      );

      final repository = ref.read(driverRepositoryProvider);

      if (widget.driver != null) {
        await repository.updateDriver(driver, _image);
      } else {
        await repository.createDriver(driver, _image);
      }

      setState(() => _isSaving = false);

      ref
          .read(rightSidebarContentController.notifier)
          .close(AddDriverWindow.name);
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
