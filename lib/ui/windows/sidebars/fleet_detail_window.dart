import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/driver_chat_model.dart';
import '../../../domain/models/driver_model.dart';
import '../../../domain/models/fleet_position_model.dart';
import '../../helpers/date_helper.dart';
import '../../providers/auth/current_user_provider.dart';
import '../../providers/common/sections/sidebar_content_controller.dart';
import '../../providers/driver/driver_chat_provider.dart';
import '../../providers/driver/driver_provider.dart';
import '../../providers/fleet/fleet_occupancy_provider.dart';
import '../../providers/fleet/fleet_position_provider.dart';
import '../../providers/fleet/fleet_provider.dart';
import '../../providers/route/route_provider.dart';
import '../../themes/app_theme.dart';
import '../../widgets/route_pill.dart';

class FleetDetailWindow extends ConsumerStatefulWidget {
  static const String name = 'window/fleet-detail';

  final String? fleetId;

  const FleetDetailWindow({
    super.key,
    required this.fleetId,
  });

  @override
  ConsumerState<FleetDetailWindow> createState() => _FleetDetailWindowState();
}

class _FleetDetailWindowState extends ConsumerState<FleetDetailWindow> {
  @override
  Widget build(BuildContext context) {
    final fleet = ref.watch(fleetProvider(widget.fleetId));
    final fleetPosition = ref.watch(fleetPositionProvider(widget.fleetId));
    final fleetOccupancy = ref.watch(fleetOccupancyProvider(widget.fleetId));

    final route = ref.watch(routeProvider(fleet?.routeId));
    final driver = ref.watch(driverProvider(fleet?.driverId));

    return Container(
      decoration: AppTheme.windowCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      fleet?.vehicleNumber ?? '-',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    if (route != null) ...[
                      const SizedBox(width: 16),
                      RoutePill(route: route),
                    ],
                  ],
                ),
                Material(
                  shape: const CircleBorder(),
                  color: Theme.of(context).colorScheme.error,
                  child: InkWell(
                    onTap: () => ref
                        .read(rightSidebarContentController.notifier)
                        .close(FleetDetailWindow.name),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengemudi',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                _buildDriverDetail(driver),
                const SizedBox(height: 16 * 2),
                Text(
                  'Kecepatan',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                _buildSpeed(fleetPosition),
                const SizedBox(height: 16),
                Text(
                  'Penumpang',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                _buildFleetOccupancy(
                  fleet?.maxCapacity ?? 0,
                  fleetOccupancy.asData?.value ?? 0,
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Komunikasi',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const Divider(height: 0),
          DriverChat(
            driverId: fleet?.driverId,
          )
        ],
      ),
    );
  }

  Widget _buildSpeed(FleetPositionModel? fleetPosition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${fleetPosition?.speed ?? '-'} km/h',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder(
          duration: 1.seconds,
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: 0,
            end: fleetPosition?.speed != null ? fleetPosition!.speed! / 100 : 0,
          ),
          builder: (context, value, _) {
            const safeSpeedTreshold = 0.45;

            const Color safeSpeed = Colors.green;
            const Color dangerSpeed = Colors.red;

            return LinearProgressIndicator(
              value: value,
              valueColor: AlwaysStoppedAnimation<Color>(
                value < safeSpeedTreshold
                    ? safeSpeed
                    : Color.lerp(
                        safeSpeed,
                        dangerSpeed,
                        (value - safeSpeedTreshold) / (1 - safeSpeedTreshold),
                      )!,
              ),
              minHeight: 12,
              borderRadius: BorderRadius.circular(999),
              backgroundColor:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
            );
          },
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              '100',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        )
      ],
    );
  }

  // just like speed
  Widget _buildFleetOccupancy(int maxCapacity, int fleetOccupancy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$fleetOccupancy dari $maxCapacity',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder(
          duration: 1.seconds,
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: 0,
            end: maxCapacity > 0 ? fleetOccupancy / maxCapacity : 0,
          ),
          builder: (context, value, _) {
            const safeOccupancyTreshold = 0.8;

            const Color safeOccupancy = Colors.green;
            const Color dangerOccupancy = Colors.red;

            return LinearProgressIndicator(
              value: value,
              valueColor: AlwaysStoppedAnimation<Color>(
                value < safeOccupancyTreshold
                    ? safeOccupancy
                    : Color.lerp(
                        safeOccupancy,
                        dangerOccupancy,
                        (value - safeOccupancyTreshold) /
                            (1 - safeOccupancyTreshold),
                      )!,
              ),
              minHeight: 12,
              borderRadius: BorderRadius.circular(999),
              backgroundColor:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
            );
          },
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              '$maxCapacity',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        )
      ],
    );
  }

  Row _buildDriverDetail(DriverModel? driver) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: driver?.image != null
              ? CachedNetworkImageProvider(driver!.image!)
              : null,
          child: driver?.image == null ? const Icon(Icons.person) : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                driver?.name ?? '-',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                driver?.phone ?? '-',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DriverChat extends ConsumerStatefulWidget {
  final String? driverId;

  const DriverChat({
    super.key,
    required this.driverId,
  });

  @override
  ConsumerState<DriverChat> createState() => _DriverChatState();
}

class _DriverChatState extends ConsumerState<DriverChat> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _sendMessage() {
    final user = ref.read(userProvider);
    final controller = ref.read(driverChatProvider(widget.driverId).notifier);

    if (widget.driverId == null ||
        _textController.text.isEmpty ||
        user.value?.uid == null) {
      return;
    }

    controller.send(_textController.text);

    _textController.clear();
    _scrollController.animateTo(
      0,
      duration: 200.milliseconds,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final chatsState = ref.watch(driverChatProvider(widget.driverId));

    if (widget.driverId == null) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.05),
        ),
        height: 300,
        child: const Center(
          child: Text('Tidak ada pengemudi'),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.05),
      ),
      height: 300,
      child: Column(
        children: [
          Expanded(
              child: chatsState.when(
            data: (chats) => chats.isEmpty
                ? const Center(
                    child: Text('Belum ada pesan'),
                  )
                : ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: chats.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      if (chats[index].senderId == user.asData?.value?.uid) {
                        return _buildMyChatBubble(chats[index]);
                      } else {
                        return _buildDriverChatBubble(chats[index]);
                      }
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                  ),
            error: (error, _) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: SizedBox(
              height: 54,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      decoration: const InputDecoration(
                        hintText: 'Ketik pesan...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      onSubmitted: (_) {
                        _sendMessage();
                        _focusNode.requestFocus();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primary,
                      child: InkWell(
                        onTap: _sendMessage,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.send_rounded,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyChatBubble(DriverChatModel chat) {
    return Align(
      alignment: Alignment.centerRight,
      child: Stack(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 100),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding:
                const EdgeInsets.all(16) + const EdgeInsets.only(bottom: 16),
            child: Text(
              chat.message ?? '-',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 16,
            child: Text(
              DateHelper.formatTime(chat.createdAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.5),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverChatBubble(DriverChatModel chat) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 100),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding:
                const EdgeInsets.all(16) + const EdgeInsets.only(bottom: 16),
            child: Text(
              chat.message ?? '-',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 16,
            child: Text(
              DateHelper.formatTime(chat.createdAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
