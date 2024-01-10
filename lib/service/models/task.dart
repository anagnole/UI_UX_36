class Task {
  final int id;
  final String title;
  final String createdAt;
  final String? updatedAt;

  Task({
    required this.id,
    required this.title,
    required this.createdAt,
    this.updatedAt,
  });

  factory Task.fromSqfliteDatabase(Map<String, dynamic> map) => Task(
        id: map['id']?.toInt() ?? 0,
        title: map['title'] ?? '',
        createdAt: DateTime.fromMicrosecondsSinceEpoch(map['created_at'])
            .toIso8601String(),
        updatedAt: map['updated_at'] == null
            ? null
            : DateTime.fromMicrosecondsSinceEpoch(map['updated_at'])
                .toIso8601String(),
      );
}
