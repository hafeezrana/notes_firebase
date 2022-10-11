import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_firebase/models/note.dart';
import 'package:note_firebase/services/firestore_service.dart';

class EditNoteView extends ConsumerStatefulWidget {
  const EditNoteView({
    required this.note,
    Key? key,
    required this.noteId,
  }) : super(key: key);

  final Note? note;
  final String? noteId;

  @override
  ConsumerState<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends ConsumerState<EditNoteView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.note!.title!;
    descriptionController.text = widget.note!.description!;
    super.initState();
  }

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
        title: const Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(left: 24, right: 24),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Update Title',
                hintText: "Edit your title...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: descriptionController,
              maxLines: 15,
              decoration: InputDecoration(
                labelText: 'Update Description',
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
                  ref.read(notesFireStoreProvider).editNote(
                      Note(
                        title: titleController.text,
                        description: descriptionController.text,
                      ),
                      widget.noteId!);

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
