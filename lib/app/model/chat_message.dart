import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String senderId;
  final String? fileUrl;
  final String text;
  final String type;
  final Timestamp timestamp;

  ChatMessage({
    required this.senderId,
    required this.text,
    required this.type,
    required this.timestamp,
    this.fileUrl,
  });

  factory ChatMessage.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return ChatMessage(
      senderId: data['senderId'],
      fileUrl: data['file_url'],
      text: data['text'],
      type: data['type'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'fileUrl': fileUrl,
      'text': text,
      'type': type,
      'timestamp': timestamp,
    };
  }
}
