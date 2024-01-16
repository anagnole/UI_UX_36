import 'dart:typed_data';
import 'package:intl/intl.dart';

class Task {
  final int id;
  final String title;
  final String category;
  final Uint8List picture;
  final String createdAt;
  final String location;
  final String? updatedAt;

  Task({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.picture,
    required this.createdAt,
    this.updatedAt,
  });

  factory Task.fromSqfliteDatabase(Map<String, dynamic> map) => Task(
        id: map['id']?.toInt() ?? 0,
        title: map['title'] ?? '',
        location: map['location'] ?? '',
        picture: map['picture'],
        category: map['category'] ?? '',
        createdAt: DateTime.fromMicrosecondsSinceEpoch(map['created_at'])
            .toIso8601String(),
        updatedAt: map['updated_at'] == null
            ? null
            : DateFormat("EEEE d 'of' MMMM y, 'at' HH:mm")
                .format(DateTime.fromMicrosecondsSinceEpoch(map['updated_at'])),
      );
}
