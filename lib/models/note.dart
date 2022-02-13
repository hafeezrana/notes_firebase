import 'dart:convert';

class Note {
  String? title;
  String? description;
  int? id;
  Note({
    this.title,
    this.description,
    this.id,
  });

  Note copyWith({
    String? title,
    String? description,
    int? id,
  }) {
    return Note(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'id': id,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      description: map['description'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() =>
      'Note(title: $title, description: $description, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.title == title &&
        other.description == description &&
        other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ id.hashCode;
}
