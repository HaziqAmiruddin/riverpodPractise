class Note {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isEdited => updatedAt != null;

  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
