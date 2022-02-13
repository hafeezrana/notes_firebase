import 'package:flutter/material.dart';
import 'package:note_firebase/views/edit_note_view.dart';

import '../models/note.dart';

class NoteDetailView extends StatefulWidget {
  NoteDetailView({
    required this.note,
    required this.noteId,
    Key? key,
  }) : super(key: key);

  Note? note;
  String? noteId;
  @override
  _NoteDetailViewState createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNoteView(
                    noteId: widget.noteId,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Center(
        child: Text(widget.note!.description!),
      ),
    );
  }
}
