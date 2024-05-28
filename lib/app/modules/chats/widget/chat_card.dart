import 'package:appifylab_task/app/model/receiver_user.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final ReceiverUser receiver;
  final Future<void> Function() onTap;
  const ChatCard({
    required this.receiver,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(receiver.photoUrl ?? ''),
              radius: 25.0,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          receiver.name ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Text('12:00'),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(receiver.email ?? '')),
                      if (true)
                        const Icon(
                          Icons.check_circle,
                          size: 16.0,
                          color: Colors.green,
                        ),
                      if (false)
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.grey,
                          size: 16.0,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(receiver.photoUrl ?? ''),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  receiver.name ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  receiver.email ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
