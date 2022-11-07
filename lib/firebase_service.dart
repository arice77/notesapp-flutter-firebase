import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  Stream<QuerySnapshot<Map<String, dynamic>>>? notesSnapshot() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return firestore
        .collection('users/${firebaseAuth.currentUser!.uid}/notes')
        .snapshots();
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future signUp(String email, String password, BuildContext context) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseAuth.currentUser != null) {
        return true;
      }
    } on FirebaseException catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  Future logIn(String email, String password, BuildContext context) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (firebaseAuth.currentUser != null) {
        return true;
      }
    } on FirebaseException catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong')));
    }
  }

  Future createNote(
      String title, String description, BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('users/${firebaseAuth.currentUser!.uid}/notes')
          .add({'Title': title, 'Description': description});
    } on FirebaseException catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  Future editNote(
      String title, String desc, String id, BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .doc('users/${firebaseAuth.currentUser!.uid}/notes/$id')
          .set({'Title': title, 'Description': desc});
    } on FirebaseException catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  Future deleteNote(String id, BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      await firebaseFirestore
          .doc('users/${firebaseAuth.currentUser!.uid}/notes/$id')
          .delete();
    } on FirebaseException catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }
}
