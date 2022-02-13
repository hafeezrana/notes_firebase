import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/models/note.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  final String? noteId;

  @override
  _EditNoteViewState createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(left: 24, right: 24),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: "Edit your title...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: "Edit your description...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('notes')
                      .doc(widget.noteId)
                      .update(Note(
                        title: titleController.text,
                        description: descriptionController.text,
                      ).toMap());
                  Navigator.of(context).pop();

                  Navigator.of(context).pop();
                },
                child: const Text('Edit ')),
          ],
        ),
      ),
    );
  }
}
