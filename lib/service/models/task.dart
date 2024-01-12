import 'dart:typed_data';

class Task {
  final int id;
  final String title;
  final String description;
  final String category;
  final Uint8List picture;
  final String createdAt;
  final String? updatedAt;

  Task({
    required this.id,
    required this.title,
    required this.category,
    required this.picture,
    required this.description,
    required this.createdAt,
    this.updatedAt,
  });

  factory Task.fromSqfliteDatabase(Map<String, dynamic> map) => Task(
        id: map['id']?.toInt() ?? 0,
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        picture: map['picture'],
        category: map['category'] ?? '',
        createdAt: DateTime.fromMicrosecondsSinceEpoch(map['created_at'])
            .toIso8601String(),
        updatedAt: map['updated_at'] == null
            ? null
            : DateTime.fromMicrosecondsSinceEpoch(map['updated_at'])
                .toIso8601String(),
      );
}
