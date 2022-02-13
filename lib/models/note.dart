import 'dart:convert';

class Note {
  String? title;
  String? description;

  Note({
    this.title,
    this.description,
  });

  Note copyWith({
    String? title,
    String? description,
  }) {
    return Note(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() => 'Note(title: $title, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;
}
