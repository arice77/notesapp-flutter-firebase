import 'package:flutter/material.dart';
import 'package:real_time_db/firebase_service.dart';
import 'package:real_time_db/screens/home_screen.dart';

class CreateNote extends StatelessWidget {
  static const routeNmae = '/create-note-screen';
  CreateNote({super.key});

  final titleController = TextEditingController();
  final desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (titleController.text.trim() == null ||
                  titleController.text.trim() == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Title can't be empty")));
              } else {
                FirestoreService()
                    .createNote(
                        titleController.text, desController.text, context)
                    .then((value) => Navigator.of(context)
                        .pushReplacementNamed(HomeScren.routeName));
              }
            },
          )
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
