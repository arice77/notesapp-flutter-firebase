import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_db/firebase_service.dart';
import 'package:real_time_db/screens/create_note_screen.dart';
import 'package:real_time_db/screens/edit_note.dart';
import 'package:real_time_db/screens/signup.dart';

class NoteDetails {
  final String title;
  final String desc;
  final String id;
  NoteDetails({required this.title, required this.desc, required this.id});
}

class HomeScren extends StatefulWidget {
  const HomeScren({super.key});
  static const routeName = '/home-screem';

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeNmae));
              },
              icon: Icon(Icons.vertical_split))
        ],
      ),
      body: StreamBuilder(
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: const Text(
              "Click '+' to add your first note",
            ));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisExtent: 150,
                childAspectRatio: 2.5),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(EditNoteScreen.routeNmae,
                      arguments: NoteDetails(
                          title: snapshot.data!.docs[index]['Title'],
                          desc: snapshot.data!.docs[index]['Description'],
                          id: snapshot.data!.docs[index].id));
                },
                child: GridTile(
                  child: Card(
                      margin: const EdgeInsets.all(8),
                      color: Color.fromRGBO(33, 150, 243, 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Column(
                          children: [
                            Expanded(
                              child: Text(
                                snapshot.data!.docs[index]['Title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Text(
                                  snapshot.data!.docs[index]['Description'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow.clip),
                            ),
                          ],
                        ),
                      )),
                ),
              );
            },
          );
        },
        stream: FirestoreService().notesSnapshot(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateNote.routeNmae);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
