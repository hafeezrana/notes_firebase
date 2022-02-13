import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/models/note.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({
    Key? key,
  }) : super(key: key);

  @override
  _AddNoteViewState createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(left: 24, right: 24),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: "Enter your title...",
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
                hintText: "Enter your description...",
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
                firestore.collection('notes').add(Note(
                        title: titleController.text,
                        description: descriptionController.text)
                    .toMap());
                Navigator.of(context).pop();
              },
              child: const Text('Add '),
            ),
          ],
        ),
      ),
    );
  }
}
