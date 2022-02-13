import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_firebase/models/note.dart';

import 'add_note_view.dart';
import 'note_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

final firestore = FirebaseFirestore.instance;

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes '),
      ),
      drawer: Drawer(
        child: Column(),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('notes').snapshots(),
          builder: (context, snaphot) {
            final noteId = snaphot.data?.docs.map((note) => note.id).toList();

            final notes = snaphot.data?.docs
                .map(
                    (note) => Note.fromMap(note.data() as Map<String, dynamic>))
                .toList();

            if (snaphot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snaphot.hasError) {
              return const Center(child: Text('Something Went Wrong'));
            }
            if (!snaphot.hasData) {
              return const Center(
                child: Text('Add New Data!'),
              );
            }
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 4,
                color: Colors.brown,
              ),
              itemCount: notes?.length ?? 0,
              itemBuilder: (context, index) {
                final note = notes![index];
                final id = index + 1;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onLongPress: () {},
                    style: ListTileStyle.list,
                    tileColor: Colors.orangeAccent,
                    hoverColor: Colors.cyan,
                    leading: CircleAvatar(
                      child: Text(id.toString()),
                    ),
                    title: Text(note.title!),
                    trailing: IconButton(
                      onPressed: () {
                        firestore
                            .collection('notes')
                            .doc(noteId![index])
                            .delete();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteDetailView(
                            noteId: noteId![index],
                            note: note,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddNoteView()),
          );
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.grey,
    );
  }
}
