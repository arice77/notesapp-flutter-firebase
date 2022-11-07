import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_time_db/firebase_service.dart';
import 'package:real_time_db/screens/home_screen.dart';

class EditNoteScreen extends StatelessWidget {
  static const routeNmae = '/edit-note';
  const EditNoteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NoteDetails;

    var titleController = TextEditingController();
    var desController = TextEditingController();
    titleController.text = args.title;
    desController.text = args.desc;
    final String docId = args.id;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (titleController.text.trim() == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tilte canot be empty')));
              } else {
                FirestoreService().editNote(
                    titleController.text, desController.text, docId, context);
                Navigator.of(context).pop();
              }
            },
          ),
          IconButton(
              onPressed: () {
                FirestoreService().deleteNote(docId, context);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: Column(children: [
            TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Title'),
                style: TextStyle(fontSize: 25)),
            TextField(
                controller: desController,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: 'Description', border: InputBorder.none)),
          ]),
        ),
      ),
    );
  }
}
