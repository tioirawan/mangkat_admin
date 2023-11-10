import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/driver_chat_model.dart';
import '../helpers/date_helper.dart';
import '../providers/auth/current_user_provider.dart';
import '../providers/driver/driver_chat_provider.dart';

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
              child: Text('$error'),
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
