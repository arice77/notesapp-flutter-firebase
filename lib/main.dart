import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:real_time_db/firebase_options.dart';
import 'package:real_time_db/screens/create_note_screen.dart';
import 'package:real_time_db/screens/edit_note.dart';
import 'package:real_time_db/screens/home_screen.dart';
import 'package:real_time_db/screens/shared_preference.dart';
import 'package:real_time_db/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _Login = false;
  @override
  void initState() {
    getLoginSataus();
    // TODO: implement initState
    super.initState();
  }

  getLoginSataus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      _Login = pref.getBool('login') == null ? false : true;
    });
    print(_Login);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _Login ? HomeScren() : LoginScreen(),
      routes: {
        HomeScren.routeName: (context) => const HomeScren(),
        LoginScreen.routeNmae: (context) => const LoginScreen(),
        CreateNote.routeNmae: (context) => CreateNote(),
        EditNoteScreen.routeNmae: (context) => const EditNoteScreen(),
      },
    );
  }
}
