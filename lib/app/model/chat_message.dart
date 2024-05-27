import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String senderId;
  final String? imageUrl;
  final String text;
  final String type;
  final Timestamp timestamp;

  ChatMessage({
    required this.senderId,
    this.imageUrl,
    required this.text,
    required this.type,
    required this.timestamp,
  });

  factory ChatMessage.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return ChatMessage(
      senderId: data['senderId'],
      imageUrl: data['imageUrl'],
      text: data['text'],
      type: data['type'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'imageUrl': imageUrl,
      'text': text,
      'type': type,
      'timestamp': timestamp,
    };
  }
}
