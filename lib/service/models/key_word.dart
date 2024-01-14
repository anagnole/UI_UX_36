class KeyWord {
  final int id;
  final String word;
  final String category;

  KeyWord({
    required this.id,
    required this.word,
    required this.category,
  });

  factory KeyWord.fromSqfliteDatabase(Map<String, dynamic> map) => KeyWord(
        id: map['id']?.toInt() ?? 0,
        word: map['word'] ?? '',
        category: map['category'] ?? '',
      );
}
