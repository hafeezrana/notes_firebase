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
        title: Text(widget.note!.title!),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNoteView(
                    noteId: widget.noteId,
                    note: widget.note,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Dialog(
          backgroundColor: Colors.grey,
          insetPadding: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.note!.description!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
            ),
          ),
        ),
      ),
    );
  }
}
